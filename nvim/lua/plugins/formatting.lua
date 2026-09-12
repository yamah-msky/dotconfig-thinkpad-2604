return {
  { "nvimtools/none-ls.nvim", enabled = false },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cf",
        function()
          require("conform").format({ lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Format",
      },
      {
        "<leader>lf",
        function()
          require("conform").format({ lsp_format = "fallback" })
        end,
        mode = { "n", "v" },
        desc = "Format",
      },
      {
        "<leader>uf",
        function()
          vim.b.autoformat = vim.b.autoformat == false
        end,
        desc = "Toggle Autoformat (buffer)",
      },
      {
        "<leader>uF",
        function()
          vim.g.autoformat = vim.g.autoformat == false
        end,
        desc = "Toggle Autoformat (global)",
      },
    },
    opts = function(_, opts)
      opts.format_on_save = function(bufnr)
        if vim.g.autoformat == false or vim.b[bufnr].autoformat == false then
          return
        end
        return { timeout_ms = 3000, lsp_format = "fallback" }
      end
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        jsonc = { "prettier" },
        yaml = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        lua = { "stylua" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        rust = { "rustfmt" },
        python = { "ruff_format" },
      })
      opts.formatters = opts.formatters or {}
      opts.formatters.prettier = vim.tbl_deep_extend("force", opts.formatters.prettier or {}, {
        prepend_args = function(_, ctx)
          local config_files = {
            ".prettierrc",
            ".prettierrc.js",
            ".prettierrc.cjs",
            ".prettierrc.json",
            ".prettierrc.yaml",
            ".prettierrc.yml",
            "prettier.config.js",
            "prettier.config.cjs",
            "prettier.config.mjs",
          }
          if #vim.fs.find(config_files, { path = ctx.dirname, upward = true }) > 0 then
            return {}
          end
          return {
            "--tab-width",
            "2",
            "--single-quote",
            "true",
            "--trailing-comma",
            "es5",
            "--print-width",
            "100",
            "--semi",
            "true",
          }
        end,
      })
    end,
  },
}
