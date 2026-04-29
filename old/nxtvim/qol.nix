{ pkgs, ... }:
{
  plugins = {
    nix-develop.enable = true;
    which-key.enable = true;
    undotree.enable = true;
    # cursorline.enable = true; # ugly line
    nvim-autopairs.enable = true;
    todo-comments.enable = true;
    treesitter = {
      enable = true;
      settings.highlight.enable = true;
      # luaConfig = ''
      #           require'nvim-treesitter.parsers'.get_parser_configs().rust = {
      #     install_info = {
      #       url = "https://github.com/tree-sitter/tree-sitter-rust",
      #       files = { "src/parser.c", "src/scanner.c" },
      #     },
      #     filetype = "rust",
      #     injections = {
      #       html = {
      #         query = [[
      #           (macro_invocation
      #             (identifier) @html_macro (#eq? @html_macro "html"))
      #         ]],
      #       },
      #     },
      #   }
      #
      # '';
    };
    numbertoggle.enable = true;
    neo-tree = {
      enable = true;
      enableRefreshOnWrite = true;
      window.position = "right";
      window.width = 24;
    };
    nvim-colorizer.enable = true;
    image = {
      enable = true;
    };
    clipboard-image = {
      enable = true;
      clipboardPackage = pkgs.wl-clipboard;
    };
    cmp-spell = {
      enable = true;
    };
  };
}
