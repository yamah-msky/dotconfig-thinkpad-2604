return {
  "AstroNvim/astrocore",
  opts = {
    treesitter = { ensure_installed = require("config.treesitter-parsers") },
    options = { opt = { clipboard = "unnamedplus" } },
  },
  config = function(_, opts)
    require("astrocore").setup(opts)
    require("config.options")
    require("config.keymaps")
    require("config.autocmds")
  end,
}
