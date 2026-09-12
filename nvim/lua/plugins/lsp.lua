local ts_inlay_hints = {
  includeInlayParameterNameHints = "all",
  includeInlayParameterNameHintsWhenArgumentMatchesName = false,
  includeInlayFunctionParameterTypeHints = true,
  includeInlayVariableTypeHints = true,
  includeInlayVariableTypeHintsWhenTypeMatchesName = false,
  includeInlayPropertyDeclarationTypeHints = true,
  includeInlayFunctionLikeReturnTypeHints = true,
  includeInlayEnumMemberValueHints = true,
}

return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      opts.features.inlay_hints = false
      opts.on_attach = function(client, bufnr)
        if vim.bo[bufnr].filetype ~= "lua" and client:supports_method("textDocument/inlayHint", bufnr) then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end
      opts.config = opts.config or {}
      opts.config.vtsls = vim.tbl_deep_extend("force", opts.config.vtsls or {}, {
        settings = {
          typescript = { inlayHints = ts_inlay_hints },
          javascript = { inlayHints = ts_inlay_hints },
        },
      })
      opts.config.cssls = opts.config.cssls or {}
      opts.config.html = opts.config.html or {}
      opts.config.emmet_ls = {
        filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
      }
      opts.config.pyright = vim.tbl_deep_extend("force", opts.config.pyright or {}, {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              diagnosticMode = "workspace",
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
            },
          },
        },
      })

      opts.config["*"].capabilities = require("cmp_nvim_lsp").default_capabilities(opts.config["*"].capabilities)
      opts.config.lua_ls =
        { settings = { Lua = { workspace = { checkThirdParty = false }, completion = { callSnippet = "Replace" } } } }
      opts.config.jsonls =
        { settings = { json = { schemas = require("schemastore").json.schemas(), validate = { enable = true } } } }
      opts.config.clangd = { cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" } }
      opts.config.ruff = {
        on_attach = function(client)
          client.server_capabilities.hoverProvider = false
        end,
      }
      opts.servers = { "vtsls", "eslint", "cssls", "html", "emmet_ls", "lua_ls", "jsonls", "clangd", "pyright", "ruff" }
      opts.handlers.rust_analyzer = false -- rustaceanvim owns this client
      opts.formatting.format_on_save.enabled = false -- Conform owns save formatting
      opts.autocmds.lsp_auto_format = false
      opts.config.eslint = { settings = { workingDirectories = { mode = "auto" }, format = true } }
      opts.mappings.n["<Leader>lr"] = { "<cmd>Telescope lsp_references<cr>", desc = "References" }
      opts.mappings.n["gi"] = { vim.lsp.buf.implementation, desc = "Goto Implementation" }
      opts.mappings.n["gt"] = { vim.lsp.buf.type_definition, desc = "Goto Type Definition" }
      opts.mappings.n["<C-k>"] = { vim.lsp.buf.signature_help, desc = "Signature Help" }
      opts.mappings.n["<Leader>rn"] = { vim.lsp.buf.rename, desc = "Rename" }
      opts.mappings.n["<Leader>d"] = { vim.diagnostic.open_float, desc = "Diagnostic Details" }
      opts.mappings.n["<Leader>ih"] = {
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
        end,
        desc = "Toggle Inlay Hints",
      }
      for _, key in ipairs({ "<Leader>lf", "<Leader>uf", "<Leader>uF" }) do
        opts.mappings.n[key] = false
      end
      opts.mappings.v["<Leader>lf"] = false
    end,
  },
  {
    "AstroNvim/astrocore",
    opts = function(_, opts)
      local severity = vim.diagnostic.severity
      opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, {
        virtual_text = { prefix = "●", source = "if_many" },
        float = { border = "rounded", source = true },
        signs = {
          text = {
            [severity.ERROR] = " ",
            [severity.WARN] = " ",
            [severity.HINT] = " ",
            [severity.INFO] = " ",
          },
          numhl = {
            [severity.ERROR] = "DiagnosticSignError",
            [severity.WARN] = "DiagnosticSignWarn",
            [severity.HINT] = "DiagnosticSignHint",
            [severity.INFO] = "DiagnosticSignInfo",
          },
        },
        jump = {
          on_jump = function(_, bufnr)
            vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
          end,
        },
      })
    end,
  },
  { "b0o/SchemaStore.nvim", lazy = true },
  { "hrsh7th/cmp-nvim-lsp", lazy = true },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "vtsls",
        "eslint-lsp",
        "css-lsp",
        "html-lsp",
        "emmet-ls",
        "lua-language-server",
        "json-lsp",
        "clangd",
        "pyright",
        "ruff",
        "rust-analyzer",
        "codelldb",
        "prettier",
        "stylua",
        "tree-sitter-cli",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = { automatic_enable = false }, -- only enable the explicitly configured servers
  },
  {
    "mrcjkb/rustaceanvim",
    ft = "rust",
    init = function()
      vim.g.rustaceanvim = {
        server = {
          default_settings = {
            ["rust-analyzer"] = {
              cargo = { allFeatures = true, buildScripts = { enable = true } },
              procMacro = { enable = true },
              checkOnSave = true,
            },
          },
        },
      }
    end,
  },
  { "Saecki/crates.nvim", event = "BufRead Cargo.toml", opts = { lsp = { enabled = true } } },
}
