return {
    "rebelot/heirline.nvim",
    config = function()
        local icons = require("icons")
        local colors = require("catppuccin.palettes.mocha")
        local conditions = require("heirline.conditions")
        local utils = require("heirline.utils")

        local Align = { provider = "%=" }
        local Space = { provider = " " }

        -- --------------------------------------------------
        -- Project location
        -- --------------------------------------------------

        local WorkDir = {
            init = function(self)
                self.icon = icons.misc.folder
                self.cwd = vim.fn.fnamemodify(vim.fn.getcwd(), ":~")
            end,
            utils.surround({ "", "" },
                colors.blue,
                {
                    hl = { fg = colors.base },
                    flexible = 10,
                    {
                        provider = function(self)
                            return self.icon .. " " .. self.cwd
                        end,
                    },
                    {
                        provider = function(self)
                            return self.icon .. " " .. vim.fn.pathshorten(self.cwd, 2)
                        end,
                    },
                    {
                        provider = function(self)
                            return self.icon .. " " .. vim.fn.pathshorten(self.cwd)
                        end,
                    },
                    {
                        provider = function(self)
                            return self.icon .. " " .. vim.fn.fnamemodify(self.cwd, ":t")
                        end,
                    },
                }),
        }

        -- --------------------------------------------------
        -- Mode
        -- --------------------------------------------------

        local ViMode = {
            init = function(self)
                self.mode = vim.fn.mode(1)
            end,
            static = {
                mode_names = { -- change the strings if you like it vvvvverbose!
                    n = "Normal",
                    no = "N?",
                    nov = "N?",
                    noV = "N?",
                    ["no\22"] = "N?",
                    niI = "Ni",
                    niR = "Nr",
                    niV = "Nv",
                    nt = "Nt",
                    v = "Visual",
                    vs = "Vs",
                    V = "V_",
                    Vs = "Vs",
                    ["\22"] = "^V",
                    ["\22s"] = "^V",
                    s = "Select",
                    S = "S_",
                    ["\19"] = "^S",
                    i = "Insert",
                    ic = "Ic",
                    ix = "Ix",
                    R = "R",
                    Rc = "Rc",
                    Rx = "Rx",
                    Rv = "Rv",
                    Rvc = "Rv",
                    Rvx = "Rv",
                    c = "CmdLine",
                    cv = "Ex",
                    r = "...",
                    rm = "M",
                    ["r?"] = "?",
                    ["!"] = "!",
                    t = "Terminal",
                },
                mode_colors = {
                    n = colors.red,
                    i = colors.green,
                    v = colors.teal,
                    V = colors.teal,
                    ["\22"] = colors.sapphire,
                    c = colors.peach,
                    s = colors.lavender,
                    S = colors.lavender,
                    ["\19"] = colors.lavender,
                    R = colors.peach,
                    r = colors.peach,
                    ["!"] = colors.red,
                    t = colors.overlay2,
                },
            },
            update = {
                "ModeChanged",
                pattern = "*:*",
                callback = vim.schedule_wrap(function()
                    vim.cmd("redrawstatus")
                end),
            },
            -- Return
            flexible = 100,
            {
                {
                    provider = function()
                        return ""
                    end,
                    hl = function(self)
                        return { fg = self.mode_colors[self.mode:sub(1, 1)] }
                    end,
                },
                {
                    provider = function(self)
                        return " %2(" .. self.mode_names[self.mode] .. "%)"
                    end,
                    hl = function(self)
                        return { fg = colors.base, bg = self.mode_colors[self.mode:sub(1, 1)], bold = false }
                    end,
                },
                {
                    provider = function()
                        return ""
                    end,
                    hl = function(self)
                        return { fg = self.mode_colors[self.mode:sub(1, 1)] }
                    end,
                },
            },
        }

        -- --------------------------------------------------
        -- LSP
        -- --------------------------------------------------

        local LSPActive = {
            condition = conditions.lsp_attached,
            update = { "LspAttach", "LspDetach" },
            on_click = {
                callback = function()
                    vim.defer_fn(function()
                        vim.cmd("LspInfo")
                    end, 100)
                end,
                name = "heirline_LSP",
            },
            utils.surround({ "", "" }, colors.green, {
                hl = { fg = colors.base },
                flexible = 20,
                {
                    provider = function()
                        local names = {}
                        for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
                            table.insert(names, server.name)
                        end
                        return "󰒍 " .. table.concat(names, " ")
                    end,
                },
                {
                    provider = function()
                        local names = {}
                        for _, server in pairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
                            table.insert(names, server.name:sub(1, 2))
                        end
                        return "󰒍 " .. table.concat(names, " ")
                    end,
                },
                {
                    provider = function()
                        return "󰒍"
                    end,
                },
            }),
        }
        -- --------------------------------------------------
        -- Git
        -- Logic borrowed from https://github.com/agoodshort/telescope-git-submodules.nvim
        -- --------------------------------------------------

        local Git = {
            condition = function()
                local path = vim.loop.cwd() .. "/.git"
                local ok = vim.loop.fs_stat(path)
                if not ok then
                    return false
                end
                return true
            end,
            on_click = {
                callback = function()
                    vim.defer_fn(function()
                        vim.cmd("Telescope git_submodules")
                    end, 100)
                end,
                name = "heirline_git",
            },
            update = { "DirChanged", "BufWritePost", "BufEnter" },

            init = function(self)
                local head_message = vim.fn.system("git rev-parse --abbrev-ref HEAD")
                if string.find(head_message, "fatal") then
                    self.current_dir_head = vim.fn.system("git branch --show-current") .. " (no origin)"
                else
                    self.current_dir_head = head_message
                end
                self.current_dir_status = vim.fn.system("git status -bs")
                self.git_status_current = ""

                for s in string.gmatch(self.current_dir_status, "[^" .. "\n" .. "]+") do
                    for w in string.gmatch(s, "[^" .. " " .. "]+") do
                        if w == "M" and string.find(self.git_status_current, "!") == nil then
                            self.git_status_current = self.git_status_current .. "!"
                        elseif w == "??" and string.find(self.git_status_current, "+") == nil then
                            self.git_status_current = self.git_status_current .. "+"
                        elseif w == "D" and string.find(self.git_status_current, "✘") == nil then
                            self.git_status_current = self.git_status_current .. "✘"
                        end
                        if
                            w == "##"
                            and string.find(self.git_status_current, "⇡") == nil
                            and string.match(s, "ahead")
                        then
                            self.git_status_current = self.git_status_current .. "⇡"
                        end
                        if
                            w == "##"
                            and string.find(self.git_status_current, "⇣") == nil
                            and string.match(s, "behind")
                        then
                            self.git_status_current = self.git_status_current .. "⇣"
                        end
                    end
                end
            end,

            utils.surround({ "", "" }, colors.rosewater, {
                hl = { fg = colors.base },
                flexible = 2,
                {
                    provider = function(self)
                        return icons.git.branch
                            .. " "
                            .. self.current_dir_head:gsub("%\n", "")
                            .. " "
                            .. self.git_status_current
                    end,
                },
                {
                    provider = function(self)
                        return icons.git.branch
                            .. " "
                            .. self.current_dir_head:gsub("%\n", ""):sub(1, 10)
                            .. "..."
                            .. " "
                            .. self.git_status_current
                    end,
                },
                {
                    provider = function(self)
                        if self.git_status_current == "" then
                            return icons.git.branch
                        else
                            return icons.git.branch .. " " .. self.git_status_current
                        end
                    end,
                },
            }),
        }
        -- --------------------------------------------------
        -- Lazy
        -- --------------------------------------------------

        local Lazy = {
            condition = require("lazy.status").has_updates,
            update = { "User", pattern = "LazyUpdate" },
            on_click = {
                callback = function()
                    vim.defer_fn(function()
                        vim.cmd("Lazy")
                    end, 100)
                end,
                name = "update_plugins",
            },
            utils.surround({ "", "" }, "lightblue", {
                hl = { fg = "black" },
                flexible = 1,
                {
                    provider = function()
                        return require("lazy.status").updates()
                    end,
                },
                {
                    provider = "",
                },
            }),
        }

        -- -- --------------------------------------------------
        -- -- Recorder
        -- -- --------------------------------------------------

        -- local Recorder = {
        --     condition = function()
        --         if require("lazy.core.config").plugins["nvim-recorder"]._.loaded then
        --             return true
        --         else
        --             return false
        --         end
        --     end,
        --     utils.surround({ "", "" }, "black", {
        --         init = function(self)
        --             self.displaySlots = require("recorder").displaySlots()
        --             self.recordingStatus = require("recorder").recordingStatus()
        --         end,
        --         provider = function(self)
        --             return self.displaySlots .. " " .. self.recordingStatus
        --         end,
        --     }),
        -- }
        require("heirline").setup({
            statusline = {
                Space,
                ViMode,
                Space,
                WorkDir,
                Space,
                Git,
                Align,
                Align,
                Lazy,
                Align,
                Align,
                Align,
                -- Recorder,
                Space,
                LSPActive,
                Space,
                Space,
                Space,
            },
            opts = {
                colors = colors,
            },
        })
    end
}
