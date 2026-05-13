{
  username,
  activeTheme,
  ...
}:
{
  home-manager.users.${username} =
    { config, ... }:
    {
      home = {
        file.".config/zed/generated/settings.json" = {
          force = true;
          text = ''
            // Zed settings
            //
            // For information on how to configure Zed, see the Zed
            // documentation: https://zed.dev/docs/configuring-zed
            //
            // To see all of Zed's default settings without changing your
            // custom settings, run `zed: open default settings` from the
            // command palette (cmd-shift-p / ctrl-shift-p)
            {
              "vim": {
                "use_smartcase_find": false,
              },
              "hover_popover_delay": 300,
              "diff_view_style": "split",
              "inline_code_actions": true,
              "gutter": {
                "min_line_number_digits": 2,
                "line_numbers": true,
              },
              "auto_signature_help": false,
              "sticky_scroll": {
                "enabled": true,
              },
              "context_servers": {},
              "outline_panel": {
                "default_width": 320.0,
                "dock": "left",
              },
              "collaboration_panel": {
                "default_width": 320.0,
                "dock": "left",
              },
              "linked_edits": true,
              "colorize_brackets": true,
              "disable_ai": true,
              "show_edit_predictions": false,
              "edit_predictions": {
                "mode": "eager",
                "copilot": {
                  "enable_next_edit_suggestions": false,
                },
                "provider": "copilot",
              },
              "git": {
                "inline_blame": {
                  "show_commit_summary": false,
                },
              },
              "agent_servers": {
                "github-copilot-cli": {
                  "favorite_config_option_values": {
                    "model": ["claude-sonnet-4.6", "claude-opus-4.6", "claude-haiku-4.5"],
                  },
                  "type": "registry",
                },
                "github-copilot": {
                  "default_model": "claude-opus-4.6",
                  "default_mode": "Ask",
                  "favorite_models": [
                    "claude-opus-4.6",
                    "claude-sonnet-4.6",
                    "claude-haiku-4.5",
                  ],
                  "type": "registry",
                },
              },
              "preview_tabs": {
                "enable_preview_from_file_finder": true,
              },
              "semantic_tokens": "combined",
              "calls": {
                "mute_on_join": true,
              },
              "terminal": {
                "shell": "system",
              },
              "scrollbar": {
                "show": "always",
              },
              "lsp_document_colors": "inlay",
              "which_key": {
                "delay_ms": 250,
                "enabled": true,
              },
              "current_line_highlight": "all",
              "unnecessary_code_fade": 0.1,
              "show_wrap_guides": true,
              "rounded_selection": false,
              "project_panel": {
                "bold_folder_labels": true,
                "auto_fold_dirs": false,
                "hide_hidden": false,
                "hide_root": false,
                "indent_guides": {
                  "show": "always",
                },
                "diagnostic_badges": true,
                "git_status_indicator": true,
                "sticky_scroll": true,
                "indent_size": 24.0,
                "dock": "left",
                "entry_spacing": "comfortable",
                "hide_gitignore": false,
                "default_width": 320.0,
                "scrollbar": {
                  "show": "always",
                  "horizontal_scroll": true,
                },
              },
              "git_panel": {
                "default_width": 320.0,
                "dock": "left",
                "tree_view": true,
              },
              "ssh_connections": [
                {
                  "host": "67.84.35.204",
                  "username": "saltcal",
                  "args": [],
                  "projects": [
                    {
                      "paths": ["/home/saltcal"],
                    },
                  ],
                  "nickname": "beta-compooper",
                },
              ],
              "icon_theme": "${
                {
                  "catppuccin-mocha" = "Catppuccin Mocha";
                  "catppuccin-frappe" = "Catppuccin Frappé";
                  "catppuccin-latte" = "Catppuccin Latte";
                }
                .${activeTheme.name} or "Zed (Default)"
              }",
              "agent": {
                "dock": "left",
                "show_turn_stats": true,
                "single_file_review": true,
                "use_modifier_to_send": true,
                "notify_when_agent_waiting": "primary_screen",
                "favorite_models": [
                  {
                    "provider": "copilot_chat",
                    "model": "claude-opus-4.6",
                    "enable_thinking": false,
                  },
                  {
                    "provider": "copilot_chat",
                    "model": "claude-sonnet-4.6",
                    "enable_thinking": false,
                  },
                  {
                    "provider": "ollama",
                    "model": "gemma2:2b",
                    "enable_thinking": false,
                  },
                ],
                "inline_assistant_model": {
                  // "provider": "copilot_chat",
                  "provider": "copilot_chat",
                  // "model": "gpt-4.1"
                  "model": "gpt-4o",
                },
                "default_model": {
                  "provider": "copilot_chat",
                  "model": "gpt-4o",
                },
                "commit_message_model": {
                  "provider": "copilot_chat",
                  "model": "claude-haiku-4.5",
                },
                "default_profile": "ask",
                "model_parameters": [],
              },
              // "file_watcher": {
              //   "exclude": [
              //     "**/.steam/**",
              //     "**/.local/share/Steam/**",
              //     "**/node_modules/**",
              //     "**/target/**"
              //   ]
              // },
              "vim_mode": true,
              "ui_font_size": 18,
              // "ui_font_family": ".SystemUIFont",
              "ui_font_family": "CaskaydiaCove Nerd Font",
              "buffer_font_size": 18,
              "buffer_font_family": "CaskaydiaCove Nerd Font",
              "ui_font_features": { "liga": true, "calt": true },
              "buffer_font_features": { "liga": true, "calt": true },
              "theme": {
                "mode": "${
                  if activeTheme.name == "catppuccin-latte" || activeTheme.name == "frutiger-aero" then
                    "light"
                  else
                    "dark"
                }",
                "light": "Catppuccin Latte",
                "dark": "${
                  {
                    "catppuccin-mocha" = "Catppuccin Mocha";
                    "catppuccin-frappe" = "Catppuccin Frappé";
                    "gruvbox-dark" = "Gruvbox Dark";
                  }
                  .${activeTheme.name} or "One Dark"
                }"
              },
              // "experimental.theme_overrides": {
              //   "background": "#00000000",
              //   "background.appearance": "blurred",
              //   "border.variant": "#00000000",
              //   "editor.active_line.background": "#9c9ca240",
              //   "editor.background": "#00000030",
              //   "editor.gutter.background": "#00000030",
              //   "panel.background": "#00000030",
              //   "scrollbar.track.border": "#00000000",
              //   "status_bar.background": "#00000030",
              //   "tab.active_background": "#ffffff10",
              //   "tab.inactive_background": "#00000000",
              //   "tab_bar.background": "#00000030",
              //   "title_bar.background": "#00000030",
              //   "toolbar.background": "#00000030",
              // },
              "relative_line_numbers": "enabled",
              "tab_bar": {
                "show": true,
              },
              // "soft_wrap": "editor_width",
              "preferred_line_length": 80,
              "wrap_guides": [80, 120],
              "indent_guides": {
                "background_coloring": "disabled",
                "enabled": true,
                "coloring": "indent_aware",
              },
              "inlay_hints": {
                "show_background": true,
                "enabled": true,
                "show_type_hints": true,
                "show_parameter_hints": true,
                "show_value_hints": true,
                "show_other_hints": true,
              },
              // "auto_signature_help": false, // obstrusive
              "auto_update": false,
              "auto_install_extensions": {
                "catppuccin": true,
                "catppuccin-icons": true,
                "html": true,
                "java": true,
                "neocmake": true,
                "nix": true,
                "toml": true,
                "lua": true,
              },
              // "show_edit_predictions": false,
              "diagnostics": {
                "inline": {
                  "enabled": true,
                },
              },
              "load_direnv": "shell_hook",
              "languages": {
                "Rust": {
                  "show_edit_predictions": false,
                  "indent_guides": {
                    "background_coloring": "disabled",
                  },
                  "always_treat_brackets_as_autoclosed": true,
                  "enable_language_server": true,
                  "format_on_save": "off",
                },
                "Python": {
                  "format_on_save": "off",
                },
                "Java": {
                  "show_edit_predictions": false,
                  "format_on_save": "off",
                },
                "Nix": {
                  "tab_size": 2,
                  "format_on_save": "on",
                  // "formatter": {
                  //   "external": {
                  //     "command": "nix", // or "alejandra"
                  //     "arguments": ["fmt", "--", "-"],
                  //   },
                  // },
                },
                "JavaScript": {
                  "tab_size": 2,
                  "format_on_save": "off",
                },
                "HTML": {
                  "indent_guides": {
                    "background_coloring": "disabled",
                    "line_width": 1,
                  },
                  "tab_size": 2,
                  "format_on_save": "on",
                },
                "CSS": {
                  "tab_size": 2,
                  "format_on_save": "off",
                },
                "C": {
                  "format_on_save": "off",
                  "tab_size": 4,
                },
              },
              "lsp": {
                "jdtls": {
                  "initialization_options": {
                    "bundles": [],
                    "workspaceFolders": [
                      "file:///home/saltcal/Code/School/25-26/APCS/Unit_2_ALGFEE/",
                      "file:///home/saltcal/Code/School/25-26/APCS/Unit_6/",
                    ],
                  },
                },
                "rust-analyzer": {
                  "initialization_options": {
                    "inlayHints": {
                      "closureCaptureHints": { "enable": true },
                      "closureReturnTypeHints": { "enable": "always" },
                      "discriminantHints": { "enable": "always" },
                      "expressionAdjustmentHints": {
                        "enable": "always",
                        "disableReborrows": false,
                        "hideOutsideUnsafe": false,
                        "mode": "prefix",
                      },
                      "genericParameterHints": {
                        "lifetime": { "enable": true },
                        "type": { "enable": true },
                      },
                      "implicitDrops": { "enable": true },
                      "impliedDynTraitHints": { "enable": true },
                      "lifetimeElisionHints": {
                        "enable": "always",
                        "useParameterNames": false,
                      },
                      "maxLength": null,
                      "parameterHints.missingArguments": { "enable": true },
                      "rangeExclusiveHints": { "enable": false },
                      "reborrowHints": { "enable": "mutable" },
                      "renderColons": false,
                    },
                  },
                },
                "hls": {
                  "initialization_options": {
                    "haskell": {
                      "formattingProvider": "fourmolu",
                    },
                  },
                },
                "nil": {
                  "initialization_options": {
                    "nix": {
                      "flake": {
                        "autoArchive": true,
                      },
                    },
                    "formatting": {
                      "command": ["nix", "fmt", "--", "-"],
                    },
                  },
                },
              },
              "extend_comment_on_newline": false,
            }
          '';
        };
        file.".config/zed/generated/keymap.json" = {
          force = true;
          text = ''
            // Zed keymap
            //
            // For information on binding keys, see the Zed
            // documentation: https://zed.dev/docs/key-bindings
            //
            // To see the default key bindings run `zed: open default keymap`
            // from the command palette.
            [
              // {
              //   "context": "Workspace",
              //   "bindings": {
              //     // "shift shift": "file_finder::Toggle"
              //   }
              // },
              // {
              //   "context": "Editor",
              //   "bindings": {
              //     // "j k": ["workspace::SendKeystrokes", "escape"]
              //   }
              // },
              {
                // "context": "VimControl",
                // "context": "VimControl && !menu",
                // "context": "VimControl",
                "context": "((Editor && mode == full) && vim_mode == normal) || (ProjectPanel && not_editing)",
                "bindings": {
                  "space t f": "file_finder::Toggle",
                  "space h": "workspace::ActivatePaneLeft",
                  "space l": "workspace::ActivatePaneRight",
                  "space k": "workspace::ActivatePaneUp",
                  "space j": "workspace::ActivatePaneDown",
                  "space f": "editor::Format",
                  "space i h": "editor::ToggleInlayHints",
                  "space n": "project_panel::Toggle",
                },
              },
              {
                "context": "Terminal",
                "bindings": {
                  // --- tmux-style pane navigation ---
                  "ctrl-space ctrl-h": "workspace::ActivatePaneLeft",
                  "ctrl-space ctrl-j": "workspace::ActivatePaneDown",
                  "ctrl-space ctrl-k": "workspace::ActivatePaneUp",
                  "ctrl-space ctrl-l": "workspace::ActivatePaneRight",

                  "alt-h": "workspace::ActivatePaneLeft",
                  "alt-j": "workspace::ActivatePaneDown",
                  "alt-k": "workspace::ActivatePaneUp",
                  "alt-l": "workspace::ActivatePaneRight",

                  "ctrl-space ctrl-alt-n": "workspace::NewTerminal",
                  "alt-n": "workspace::NewTerminal",

                  // --- tmux-style pane splitting ---
                  "ctrl-space ctrl-%": "pane::SplitVertical",
                  "ctrl-space ctrl-\"": "pane::SplitHorizontal",

                  // --- tmux-style terminal toggle & editor jump ---
                  "ctrl-space t": "terminal_panel::Toggle",
                  "ctrl-space e": "editor::ToggleFocus",

                  // // --- tmux-style pane resizing (H/J/K/L) ---
                  // "ctrl-space H": ["vim::ResizePaneLeft", { "px": 10 }],
                  // "ctrl-space J": ["vim::ResizePaneDown", { "px": 10 }],
                  // "ctrl-space K": ["vim::ResizePaneUp", { "px": 10 }],
                  // "ctrl-space L": ["vim::ResizePaneRight", { "px": 10 }],
                },
              },
              {
                "context": "VimControl && !menu && extension == md",
                "bindings": {
                  "j": ["vim::Down", { "display_lines": true }],
                  "k": ["vim::Up", { "display_lines": true }],
                  "0": ["vim::StartOfLine", { "display_lines": true }],
                  "$": ["vim::EndOfLine", { "display_lines": true }],
                },
              },
              {
                "context": "(Editor && (showing_code_actions || showing_completions))",
                "bindings": {
                  "ctrl-j": "editor::ContextMenuNext",
                  "ctrl-k": "editor::ContextMenuPrevious",
                },
              },
              {
                "context": "FileFinder > Picker > Editor",
                "bindings": {
                  "ctrl-j": "menu::SelectNext",
                  "ctrl-k": "menu::SelectPrevious",
                },
              },
              {
                "context": "(Editor && showing_completions)",
                "bindings": {
                  "ctrl-enter": "editor::ConfirmCompletionReplace",
                },
              },
              {
                "bindings": {
                  "ctrl-q": "zed::Quit",
                },
              },
              {
                "bindings": {
                  "ctrl-alt-x": "agent::ToggleFocus",
                },
              },
              {
                "bindings": {
                  "ctrl-alt-z": "workspace::ToggleLeftDock",
                },
              },
              {
                "context": "AgentPanel",
                "bindings": {
                  "ctrl-alt-z": null,
                },
              },
              {
                "context": "(ProjectPanel && not_editing)",
                "bindings": {
                  "a": "project_panel::NewFile",
                },
              },
              {
                "context": "(ProjectPanel && not_editing)",
                "bindings": {
                  "space": null,
                },
              },
              {
                "context": "(ProjectPanel && not_editing)",
                "bindings": {
                  "r": "project_panel::Rename",
                },
              },
              {
                "context": "(ProjectPanel && not_editing)",
                "bindings": {
                  "shift-r": null,
                },
              },
              {
                "context": "(ProjectPanel && not_editing)",
                "bindings": {
                  "d": "project_panel::Delete",
                },
              },
              {
                "context": "(ProjectPanel && not_editing)",
                "bindings": {
                  "%": null,
                },
              },
              {
                "context": "Editor",
                "bindings": {
                  "ctrl-shift-k": null,
                },
              },
              {
                "context": "Workspace",
                "bindings": {
                  "ctrl-shift-r": [
                    "task::Rerun",
                    {
                      "reevaluate_context": false,
                    },
                  ],
                },
              },
              {
                "context": "AcpThread > Editor",
                "unbind": {
                  "ctrl-enter": "agent::ChatWithFollow",
                },
              },
              {
                "context": "!AcpThread > Editor && mode == full",
                "unbind": {
                  "ctrl-enter": "assistant::InlineAssist",
                },
              },
              {
                "context": "Terminal",
                "unbind": {
                  "ctrl-enter": "assistant::InlineAssist",
                },
              },
            ]
          '';
        };
        file.".config/zed/generated/tasks.json" = {
          force = true;
          text = ''
            // Project tasks configuration. See https://zed.dev/docs/tasks for documentation.
            //
            // Example:
            [
              // {
              //   "label": "clear jdtls cache",
              //   "command": "rm -rf ~/.cache/jdtls*; done",
              //   "use_new_terminal": false,
              //   "allow_concurrent_runs": false,
              //   "reveal": "never",
              //   "reveal_target": "dock",
              //   "hide": "always",
              //   "shell": "system",
              //   "show_summary": false,
              //   "show_command": false
              // },
              {
                "label": "Example task",
                "command": "for i in {1..5}; do echo \"Hello $i/5\"; sleep 1; done",
                //"args": [],
                // Env overrides for the command, will be appended to the terminal's environment from the settings.
                "env": { "foo": "bar" },
                // Current working directory to spawn the command into, defaults to current project root.
                //"cwd": "/path/to/working/directory",
                // Whether to use a new terminal tab or reuse the existing one to spawn the process, defaults to `false`.
                "use_new_terminal": false,
                // Whether to allow multiple instances of the same task to be run, or rather wait for the existing ones to finish, defaults to `false`.
                "allow_concurrent_runs": false,
                // What to do with the terminal pane and tab, after the command was started:
                // * `always` — always show the task's pane, and focus the corresponding tab in it (default)
                // * `no_focus` — always show the task's pane, add the task's tab in it, but don't focus it
                // * `never` — do not alter focus, but still add/reuse the task's tab in its pane
                "reveal": "always",
                // Where to place the task's terminal item after starting the task:
                // * `dock` — in the terminal dock, "regular" terminal items' place (default)
                // * `center` — in the central pane group, "main" editor area
                "reveal_target": "dock",
                // What to do with the terminal pane and tab, after the command had finished:
                // * `never` — Do nothing when the command finishes (default)
                // * `always` — always hide the terminal tab, hide the pane also if it was the last tab in it
                // * `on_success` — hide the terminal tab on task success only, otherwise behaves similar to `always`
                "hide": "never",
                // Which shell to use when running a task inside the terminal.
                // May take 3 values:
                // 1. (default) Use the system's default terminal configuration in /etc/passwd
                //      "shell": "system"
                // 2. A program:
                //      "shell": {
                //        "program": "sh"
                //      }
                // 3. A program with arguments:
                //     "shell": {
                //         "with_arguments": {
                //           "program": "/bin/bash",
                //           "args": ["--login"]
                //         }
                //     }
                "shell": "system",
                // Whether to show the task line in the output of the spawned task, defaults to `true`.
                "show_summary": true,
                // Whether to show the command line in the output of the spawned task, defaults to `true`.
                "show_command": true
                // Represents the tags for inline runnable indicators, or spawning multiple tasks at once.
                // "tags": []
              }
            ]
          '';
        };
      };
      home.activation.setupZedConfigs = config.lib.dag.entryAfter [ "onFilesChange" ] ''
        ZED_DIR="/home/${username}/.config/zed"
        BACKUP_DIR="$ZED_DIR/backups/$(date +%Y%m%d_%H%M%S)"

        $DRY_RUN_CMD mkdir -p "$ZED_DIR"

        for file in settings.json keymap.json tasks.json; do
          # if the file exists and NOT a symlink
          if [ -f "$ZED_DIR/$file" ] && [ ! -L "$ZED_DIR/$file" ]; then
            $DRY_RUN_CMD mkdir -p "$BACKUP_DIR"
            $DRY_RUN_CMD mv "$ZED_DIR/$file" "$BACKUP_DIR/"
          fi

          # if symlink, DIE
          $DRY_RUN_CMD rm -f "$ZED_DIR/$file"

          # Only proceed if Home Manager has finished creating the generated source
          if [ -f "$ZED_DIR/generated/$file" ]; then
            # `-L` derefs it
            $DRY_RUN_CMD cp -L "$ZED_DIR/generated/$file" "$ZED_DIR/$file"

            # ensures writability
            $DRY_RUN_CMD chmod +w "$ZED_DIR/$file"
          fi
        done
      '';
    };
}
