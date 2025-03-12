{ pkgs
, lib
, ...
}: {
  imports = [
    ./keymaps.nix
    ./plugins.nix
  ];

  programs.nixvim = {
    config = {
      viAlias = true;
      opts = {
        number = true;
        relativenumber = true;
        autoindent = true;
        shiftwidth = 2;
        incsearch = true;
        swapfile = false;
        expandtab = true;
        mouse = null;

        updatetime = 50; # faster completion
        autowrite = true;
        confirm = true;
        clipboard = "unnamedplus";
        cursorline = true;
        shiftround = true;
        signcolumn = "yes";

        ignorecase = true;
        undofile = true; # Build-in persistent undo
        undolevels = 10000;
      };

      plugins = {
        nvim-autopairs = {
          enable = true;
          settings = {
            disable_filetype = [
              "TelescopePrompt"
              "vim"
            ];
          };
        };

        cmp-emoji = {
          enable = true;
        };
        cmp = {
          enable = true;
          settings = {
            autoEnableSources = true;
            experimental = {
              ghost_text = false;
            };
            performance = {
              debounce = 60;
              fetchingTimeout = 200;
              maxViewEntries = 30;
            };
            snippet = {
              expand = "luasnip";
            };
            formatting = {
              fields = [
                "kind"
                "abbr"
                "menu"
              ];
            };
            sources = [
              { name = "git"; }
              { name = "nvim_lsp"; }
              { name = "emoji"; }
              {
                name = "buffer"; # text within current buffer
                option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
                keywordLength = 3;
              }
              {
                name = "path"; # file system paths
                keywordLength = 3;
              }
              {
                name = "luasnip"; # snippets
                keywordLength = 3;
              }
            ];

            window = {
              completion = {
                border = "solid";
              };
              documentation = {
                border = "solid";
              };
            };

            mapping = {
              "<C-Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
              "<C-j>" = "cmp.mapping.select_next_item()";
              "<C-k>" = "cmp.mapping.select_prev_item()";
              "<C-e>" = "cmp.mapping.abort()";
              "<C-b>" = "cmp.mapping.scroll_docs(-4)";
              "<C-f>" = "cmp.mapping.scroll_docs(4)";
              "<C-Space>" = "cmp.mapping.complete()";
              "<C-CR>" = "cmp.mapping.confirm({ select = true })";
              "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
            };
          };
        };
        cmp-nvim-lsp = {
          enable = true;
        }; # lsp
        cmp-buffer = {
          enable = true;
        };
        cmp-path = {
          enable = true;
        }; # file system paths
        cmp_luasnip = {
          enable = true;
        }; # snippets
        cmp-cmdline = {
          enable = false;
        }; # autocomplete for cmdline

        luasnip.enable = true;
        nix.enable = true;

        which-key.enable = true;
        # lsp = {
        #   enable = true;
        #   servers = {
        #     nixd.enable = true;
        #     kotlin_language_server.enable = true;
        #     # pyright.enable = true;
        #     # jdtls.enable = true;
        #     # ts_ls.enable = true;
        #     pylsp = {
        #       enable = true;
        #       # settings.plugins = {
        #         # black.enabled = true;
        #         # flake8.enabled = true;
        #         # isort.enabled = true;
        #         # jedi.enabled = true;
        #         # mccabe.enabled = true;
        #         # pycodestyle.enabled = true;
        #         # pydocstyle.enabled = true;
        #         # pyflakes.enabled = true;
        #         # pylint.enabled = true;
        #         # rope.enabled = true;
        #         # yapf.enabled = true;
        #       # };
        #     };
        #   };
        # };

        lspkind.enable = true;

        conform-nvim = {
          enable = true;
          settings = {
            format_on_save = ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

                if slow_format_filetypes[vim.bo[bufnr].filetype] then
                  return
                end

                local function on_format(err)
                  if err and err:match("timeout$") then
                    slow_format_filetypes[vim.bo[bufnr].filetype] = true
                  end
                end

                return { timeout_ms = 200, lsp_fallback = true }, on_format
              end
            '';

            format_after_save = ''
              function(bufnr)
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return
                end

                if not slow_format_filetypes[vim.bo[bufnr].filetype] then
                  return
                end

                return { lsp_fallback = true }
              end
            '';
            notify_on_error = true;
            formatters_by_ft = {
              kotlin = [
                "ktfmt"
              ];
              java = [
                "google-java-format"
              ];
              html = {
                __unkeyed-1 = "prettierd";
              };
              css = {
                __unkeyed-1 = "prettierd";
                stop_after_first = true;
              };
              javascript = {
                __unkeyed-1 = "prettierd";
                stop_after_first = true;
              };
              typescript = {
                __unkeyed-1 = "prettierd";
                stop_after_first = true;
              };
              python = {
                __unkeyed-1 = "black";
                __unkeyed-2 = "isort";
                stop_after_first = true;
              };
              lua = [ "stylua" ];
              nix = [ "nixpkgs-fmt" ];
              markdown = {
                __unkeyed-1 = "prettierd";
                timeout_ms = 2000;
                stop_after_first = true;
              };
              yaml = [
                [
                  "prettierd"
                ]
              ];
              terraform = [ "terraform_fmt" ];
              bicep = [ "bicep" ];
              bash = [
                "shellcheck"
                "shellharden"
                "shfmt"
              ];
              json = [ "jq" ];
              "_" = [ "trim_whitespace" ];
            };

            formatters = {
              ktfmt = {
                command = "${lib.getExe pkgs.ktfmt}";
              };
              google-java-format = {
                command = "${lib.getExe pkgs.google-java-format}";
              };
              black = {
                command = "${lib.getExe pkgs.black}";
              };
              isort = {
                command = "${lib.getExe pkgs.isort}";
              };
              nixpkgs-fmt = {
                command = "${lib.getExe pkgs.nixpkgs-fmt}";
              };
              alejandra = {
                command = "${lib.getExe pkgs.alejandra}";
              };
              jq = {
                command = "${lib.getExe pkgs.jq}";
              };
              prettierd = {
                command = "${lib.getExe pkgs.prettierd}";
              };
              stylua = {
                command = "${lib.getExe pkgs.stylua}";
              };
              shellcheck = {
                command = "${lib.getExe pkgs.shellcheck}";
              };
              shfmt = {
                command = "${lib.getExe pkgs.shfmt}";
              };
              shellharden = {
                command = "${lib.getExe pkgs.shellharden}";
              };
              bicep = {
                command = "${lib.getExe pkgs.bicep}";
              };
              #yamlfmt = {
              #  command = "${lib.getExe pkgs.yamlfmt}";
              #};
            };
          };
        };

        fidget = {
          enable = true;
          logger = {
            level = "warn"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
            floatPrecision = 1.0e-2; # Limit the number of decimals displayed for floats
          };
          progress = {
            pollRate = 0; # How and when to poll for progress messages
            suppressOnInsert = true; # Suppress new messages while in insert mode
            ignoreDoneAlready = false; # Ignore new tasks that are already complete
            ignoreEmptyMessage = false; # Ignore new tasks that don't contain a message
            clearOnDetach =
              # Clear notification group when LSP server detaches
              ''
                function(client_id)
                  local client = vim.lsp.get_client_by_id(client_id)
                  return client and client.name or nil
                end
              '';
            notificationGroup =
              # How to get a progress message's notification group key
              ''
                function(msg) return msg.lsp_client.name end
              '';
            ignore = [ ]; # List of LSP servers to ignore
            lsp = {
              progressRingbufSize = 0; # Configure the nvim's LSP progress ring buffer size
            };
            display = {
              renderLimit = 16; # How many LSP messages to show at once
              doneTtl = 3; # How long a message should persist after completion
              doneIcon = "✔"; # Icon shown when all LSP progress tasks are complete
              doneStyle = "Constant"; # Highlight group for completed LSP tasks
              progressTtl = "math.huge"; # How long a message should persist when in progress
              progressIcon = {
                pattern = "dots";
                period = 1;
              }; # Icon shown when LSP progress tasks are in progress
              progressStyle = "WarningMsg"; # Highlight group for in-progress LSP tasks
              groupStyle = "Title"; # Highlight group for group name (LSP server name)
              iconStyle = "Question"; # Highlight group for group icons
              priority = 30; # Ordering priority for LSP notification group
              skipHistory = true; # Whether progress notifications should be omitted from history
              formatMessage = ''
                require ("fidget.progress.display").default_format_message
              ''; # How to format a progress message
              formatAnnote = ''
                function (msg) return msg.title end
              ''; # How to format a progress annotation
              formatGroupName = ''
                function (group) return tostring (group) end
              ''; # How to format a progress notification group's name
              overrides = {
                rust_analyzer = {
                  name = "rust-analyzer";
                };
              }; # Override options from the default notification config
            };
          };
          notification = {
            pollRate = 10; # How frequently to update and render notifications
            filter = "info"; # “off”, “error”, “warn”, “info”, “debug”, “trace”
            historySize = 128; # Number of removed messages to retain in history
            overrideVimNotify = true;
            redirect = ''
              function(msg, level, opts)
                if opts and opts.on_open then
                  return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
                end
              end
            '';
            configs = {
              default = "require('fidget.notification').default_config";
            };

            window = {
              normalHl = "Comment";
              winblend = 0;
              border = "none"; # none, single, double, rounded, solid, shadow
              zindex = 45;
              maxWidth = 0;
              maxHeight = 0;
              xPadding = 1;
              yPadding = 0;
              align = "bottom";
              relative = "editor";
            };
            view = {
              stackUpwards = true; # Display notification items from bottom to top
              iconSeparator = " "; # Separator between group name and icon
              groupSeparator = "---"; # Separator between notification groups
              groupSeparatorHl =
                # Highlight group used for group separator
                "Comment";
            };
          };
        };

        lsp-lines = {
          enable = true;
        };
        lsp-format = {
          enable = true;
        };
        helm = {
          enable = true;
        };
        lsp = {
          enable = true;
          inlayHints = true;
          servers = {
            # nixd.enable = true;
            # ltex = {
            #   enable = true;
            #   settings.language = "en-US";
            # };
            texlab = {
              enable = true;
            };
            jdtls = {
              enable = true;
            };
            html = {
              enable = true;
            };
            cssls = {
              enable = true;
            };
            lua_ls = {
              enable = true;
            };
            nil_ls.enable = true;
            ts_ls = {
              enable = true;
            };
            marksman = {
              enable = true;
            };
            pyright = {
              enable = true;
            };
            gopls = {
              enable = true;
            };
            terraformls = {
              enable = true;
            };
            ansiblels = {
              enable = true;
            };
            jsonls = {
              enable = true;
            };
            helm_ls = {
              enable = true;
              extraOptions = {
                settings = {
                  "helm_ls" = {
                    yamlls = {
                      path = "${pkgs.yaml-language-server}/bin/yaml-language-server";
                    };
                  };
                };
              };
            };
            yamlls = {
              enable = true;
              extraOptions = {
                settings = {
                  yaml = {
                    schemas = {
                      kubernetes = "'*.yaml";
                      "http://json.schemastore.org/github-workflow" = ".github/workflows/*";
                      "http://json.schemastore.org/github-action" = ".github/action.{yml,yaml}";
                      "http://json.schemastore.org/ansible-stable-2.9" = "roles/tasks/*.{yml,yaml}";
                      "http://json.schemastore.org/kustomization" = "kustomization.{yml,yaml}";
                      "http://json.schemastore.org/ansible-playbook" = "*play*.{yml,yaml}";
                      "http://json.schemastore.org/chart" = "Chart.{yml,yaml}";
                      "https://json.schemastore.org/dependabot-v2" = ".github/dependabot.{yml,yaml}";
                      "https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json" = "*docker-compose*.{yml,yaml}";
                      "https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json" = "*flow*.{yml,yaml}";
                    };
                  };
                };
              };
            };
          };
        };
      };

      extraConfigLuaPre =
        # lua
        ''
          local slow_format_filetypes = {}

          vim.api.nvim_create_user_command("FormatDisable", function(args)
             if args.bang then
              -- FormatDisable! will disable formatting just for this buffer
              vim.b.disable_autoformat = true
            else
              vim.g.disable_autoformat = true
            end
          end, {
            desc = "Disable autoformat-on-save",
            bang = true,
          })
          vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
          end, {
            desc = "Re-enable autoformat-on-save",
          })
          vim.api.nvim_create_user_command("FormatToggle", function(args)
            if args.bang then
              -- Toggle formatting for current buffer
              vim.b.disable_autoformat = not vim.b.disable_autoformat
            else
              -- Toggle formatting globally
              vim.g.disable_autoformat = not vim.g.disable_autoformat
            end
          end, {
            desc = "Toggle autoformat-on-save",
            bang = true,
          })
        '';

      extraConfigLua = ''
            luasnip = require("luasnip")
            kind_icons = {
              Text = "󰊄",
              Method = " ",
              Function = "󰡱 ",
              Constructor = " ",
              Field = " ",
              Variable = "󱀍 ",
              Class = " ",
              Interface = " ",
              Module = "󰕳 ",
              Property = " ",
              Unit = " ",
              Value = " ",
              Enum = " ",
              Keyword = " ",
              Snippet = " ",
              Color = " ",
              File = "",
              Reference = " ",
              Folder = " ",
              EnumMember = " ",
              Constant = " ",
              Struct = " ",
              Event = " ",
              Operator = " ",
              TypeParameter = " ",
            }

             local cmp = require'cmp'

         -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
         cmp.setup.cmdline({'/', "?" }, {
           sources = {
             { name = 'buffer' }
           }
         })

        -- Set configuration for specific filetype.
         cmp.setup.filetype('gitcommit', {
           sources = cmp.config.sources({
             { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
           }, {
             { name = 'buffer' },
           })
         })

         -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
         cmp.setup.cmdline(':', {
           sources = cmp.config.sources({
             { name = 'path' }
           }, {
             { name = 'cmdline' }
           }),
         })

         local _border = "rounded"

         vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
           vim.lsp.handlers.hover, {
             border = _border
           }
         )

         vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
           vim.lsp.handlers.signature_help, {
             border = _border
           }
         )

         vim.diagnostic.config{
           float={border=_border}
         };

         require('lspconfig.ui.windows').default_options = {
           border = _border
         }

         print("salutations, nix boy.")
      '';

      extraPlugins = [
        pkgs.vimPlugins.vim-be-good
        pkgs.vimPlugins.ansible-vim
      ];

      colorschemes.catppuccin = {
        enable = true;
        settings = {
          transparent_background = true;
          # color_overrides = {
          #   mocha = {
          #   base = "#1e1e2f";
          #   };
          # };
          disable_underline = true;
          flavour = "frappe"; # latte or frappe
          integrations = {
            cmp = true;
            gitsigns = true;
            mini = {
              enabled = true;
              indentscope_color = "";
            };
            notify = true;
            nvimtree = true;
            treesitter = true;
          };
          styles = {
            booleans = [
              "bold"
              "italic"
            ];
            conditionals = [
              "bold"
            ];
            variables = [
              "italic"
            ];
            functions = [
              "bold"
              "italic"
            ];
          };
          term_colors = true;
        };

        # settings = {
        #   enable_sidebar_background = true;
        # };
      };

      enable = true;
      enableMan = true;
      defaultEditor = true;
      clipboard.providers.wl-copy.enable = true;
      # termiguicolors = true; # not how it works, but i want it somehow
    };
  };

  environment.systemPackages = [
    pkgs.nodePackages.typescript-language-server
    pkgs.vimPlugins.vim-be-good
    pkgs.wl-clipboard
    pkgs.python312Packages.pylatexenc
  ];
}
