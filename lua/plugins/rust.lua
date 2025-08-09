-- ~/.config/nvim/lua/plugins/rust.lua
return {
  -- Rustaceanvim - Modern Rust tooling for Neovim
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- Recommended to pin to major version
    lazy = false, -- Already lazy loaded by filetype
    ft = { "rust" },
    opts = {
      server = {
        -- rust-analyzer configuration
        on_attach = function(client, bufnr)
          -- Custom on_attach logic here if needed
          -- LazyVim's default LSP on_attach will still run
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
            inlayHints = {
              bindingModeHints = {
                enable = false,
              },
              chainingHints = {
                enable = true,
              },
              closingBraceHints = {
                enable = true,
                minLines = 25,
              },
              closureReturnTypeHints = {
                enable = "never",
              },
              lifetimeElisionHints = {
                enable = "never",
                useParameterNames = false,
              },
              maxLength = 25,
              parameterHints = {
                enable = true,
              },
              reborrowHints = {
                enable = "never",
              },
              renderColons = true,
              typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
          },
        },
      },
      -- DAP configuration
      dap = {
        adapter = {
          type = "executable",
          command = "lldb-vscode",
          name = "rt_lldb",
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})

      -- Set up keymaps
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()

          -- Rustacean keymaps
          vim.keymap.set("n", "<leader>rr", function()
            vim.cmd.RustLsp("run")
          end, { desc = "Run Rust", buffer = bufnr })

          vim.keymap.set("n", "<leader>rt", function()
            vim.cmd.RustLsp("testables")
          end, { desc = "Run Rust Tests", buffer = bufnr })

          vim.keymap.set("n", "<leader>rd", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Debug Rust", buffer = bufnr })

          vim.keymap.set("n", "<leader>rD", function()
            vim.cmd.RustLsp({ "renderDiagnostic", "current" })
          end, { desc = "Render Diagnostic", buffer = bufnr })

          vim.keymap.set("n", "<leader>rc", function()
            vim.cmd.RustLsp("openCargo")
          end, { desc = "Open Cargo.toml", buffer = bufnr })

          vim.keymap.set("n", "<leader>rp", function()
            vim.cmd.RustLsp("parentModule")
          end, { desc = "Parent Module", buffer = bufnr })

          vim.keymap.set("n", "<leader>rm", function()
            vim.cmd.RustLsp("expandMacro")
          end, { desc = "Expand Macro", buffer = bufnr })

          vim.keymap.set("n", "<leader>rg", function()
            vim.cmd.RustLsp("crateGraph")
          end, { desc = "View Crate Graph", buffer = bufnr })

          vim.keymap.set("n", "<leader>rR", function()
            vim.cmd.RustLsp("reloadWorkspace")
          end, { desc = "Reload Workspace", buffer = bufnr })

          vim.keymap.set("n", "<leader>rS", function()
            vim.cmd.RustLsp("syntaxTree")
          end, { desc = "Syntax Tree", buffer = bufnr })

          vim.keymap.set("n", "<leader>rh", function()
            vim.cmd.RustLsp({ "hover", "actions" })
          end, { desc = "Hover Actions", buffer = bufnr })

          vim.keymap.set("n", "<leader>re", function()
            vim.cmd.RustLsp("explainError")
          end, { desc = "Explain Error", buffer = bufnr })

          vim.keymap.set("n", "<leader>rE", function()
            vim.cmd.RustLsp("renderDiagnostic")
          end, { desc = "Render All Diagnostics", buffer = bufnr })

          -- Join lines for better Rust editing
          vim.keymap.set("n", "J", function()
            vim.cmd.RustLsp("joinLines")
          end, { desc = "Join Lines", buffer = bufnr })
        end,
      })
    end,
  },

  -- Crates.nvim - Cargo.toml dependency management
  {
    "saecki/crates.nvim",
    tag = "stable",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = { "toml" },
    opts = {
      completion = {
        cmp = {
          enabled = true,
        },
        crates = {
          enabled = true,
          max_results = 8,
          min_chars = 3,
        },
      },
      lsp = {
        enabled = true,
        on_attach = function(client, bufnr)
          -- Custom on_attach for crates LSP
        end,
        actions = true,
        completion = true,
        hover = true,
      },
      popup = {
        autofocus = true,
        hide_on_select = true,
        copy_register = '"',
        style = "minimal",
        border = "rounded",
        show_version_date = false,
        show_dependency_version = true,
        max_height = 30,
        min_width = 20,
        padding = 1,
      },
      src = {
        cmp = {
          enabled = true,
        },
      },
      null_ls = {
        enabled = false, -- We'll use conform.nvim instead
        name = "crates.nvim",
      },
      text = {
        loading = "   Loading...",
        version = "   %s",
        prerelease = "   %s",
        yanked = "   %s yanked",
        nomatch = "   Not found",
        upgrade = "   %s",
        error = "   Error fetching crate",
      },
      highlight = {
        loading = "CratesNvimLoading",
        version = "CratesNvimVersion",
        prerelease = "CratesNvimPreRelease",
        yanked = "CratesNvimYanked",
        nomatch = "CratesNvimNoMatch",
        upgrade = "CratesNvimUpgrade",
        error = "CratesNvimError",
      },
    },
    config = function(_, opts)
      require("crates").setup(opts)

      -- Set up keymaps for Cargo.toml files
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "toml",
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          local filename = vim.api.nvim_buf_get_name(bufnr)

          -- Only set keymaps for Cargo.toml files
          if filename:match("Cargo%.toml$") then
            local crates = require("crates")

            -- Crates management keymaps
            vim.keymap.set("n", "<leader>ct", crates.toggle, { desc = "Toggle Crates", buffer = bufnr })
            vim.keymap.set("n", "<leader>cr", crates.reload, { desc = "Reload Crates", buffer = bufnr })
            vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, { desc = "Show Versions", buffer = bufnr })
            vim.keymap.set("n", "<leader>cf", crates.show_features_popup, { desc = "Show Features", buffer = bufnr })
            vim.keymap.set(
              "n",
              "<leader>cd",
              crates.show_dependencies_popup,
              { desc = "Show Dependencies", buffer = bufnr }
            )

            -- Update keymaps
            vim.keymap.set("n", "<leader>cu", crates.update_crate, { desc = "Update Crate", buffer = bufnr })
            vim.keymap.set("v", "<leader>cu", crates.update_crates, { desc = "Update Crates", buffer = bufnr })
            vim.keymap.set("n", "<leader>ca", crates.update_all_crates, { desc = "Update All Crates", buffer = bufnr })
            vim.keymap.set("n", "<leader>cU", crates.upgrade_crate, { desc = "Upgrade Crate", buffer = bufnr })
            vim.keymap.set("v", "<leader>cU", crates.upgrade_crates, { desc = "Upgrade Crates", buffer = bufnr })
            vim.keymap.set(
              "n",
              "<leader>cA",
              crates.upgrade_all_crates,
              { desc = "Upgrade All Crates", buffer = bufnr }
            )

            -- Documentation and homepage
            vim.keymap.set(
              "n",
              "<leader>cx",
              crates.expand_plain_crate_to_inline_table,
              { desc = "Expand Crate", buffer = bufnr }
            )
            vim.keymap.set(
              "n",
              "<leader>cX",
              crates.extract_crate_into_table,
              { desc = "Extract Crate", buffer = bufnr }
            )

            -- Open external links
            vim.keymap.set("n", "<leader>cH", crates.open_homepage, { desc = "Open Homepage", buffer = bufnr })
            vim.keymap.set("n", "<leader>cR", crates.open_repository, { desc = "Open Repository", buffer = bufnr })
            vim.keymap.set(
              "n",
              "<leader>cD",
              crates.open_documentation,
              { desc = "Open Documentation", buffer = bufnr }
            )
            vim.keymap.set("n", "<leader>cC", crates.open_crates_io, { desc = "Open Crates.io", buffer = bufnr })
          end
        end,
      })
    end,
  },

  -- Ensure rust-analyzer is disabled in mason-lspconfig since rustaceanvim handles it
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = {
      ensure_installed = {
        -- Don't include rust_analyzer here since rustaceanvim manages it
      },
    },
  },

  -- Configure nvim-lspconfig to not set up rust-analyzer
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        -- Make sure rust_analyzer is not configured here
        rust_analyzer = false,
      },
    },
  },

  -- Add DAP support for Rust debugging
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "codelldb" })
        end,
      },
    },
  },

  -- Configure conform.nvim for Rust formatting
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        rust = { "rustfmt" },
      },
    },
  },

  -- Add Rust treesitter support
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "rust", "ron", "toml" })
    end,
  },

  -- Add which-key descriptions for Rust keymaps
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {},
    },
  },
}
