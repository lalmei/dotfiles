return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local config = require("nvim-treesitter.configs")
        config.setup({
            ensure_installed = { "lua", "python", "cpp", "bash", "go", "typescript",
                "rust", "dockerfile", "css", "fortran", "sql", "tmux",
                "git_config", "regex", "gitattributes",
                "gitignore", "json", "javascript", "latex", "make" },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
