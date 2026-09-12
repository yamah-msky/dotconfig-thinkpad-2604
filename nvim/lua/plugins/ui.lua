return {
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "AstroNvim/astroui",
    opts = { colorscheme = "monokai-pro" },
  },
  {
    "loctvl842/monokai-pro.nvim",
    priority = 1000,
    opts = {
      devicons = true,
      filter = "pro",
    },
  },
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>e", false },
      { "<leader>E", false },
    },
    opts = { explorer = { enabled = false }, picker = { enabled = false }, indent = { enabled = false } },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile" },
    keys = { { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File Tree" } },
    opts = {
      filters = { dotfiles = false },
      renderer = { group_empty = true },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "User AstroFile",
    opts = {
      indent = { char = "|" },
      scope = { enabled = true },
    },
  },
}
