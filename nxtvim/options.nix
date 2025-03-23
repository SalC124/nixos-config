{ ... }:
{
  config = {
    viAlias = true;
    vimAlias = false;
    opts = {
      number = true;
      relativenumber = true;
      autoindent = true;
      shiftwidth = 2;
      incsearch = true;
      swapfile = false;
      expandtab = true;
      mouse = null;

      updatetime = 32; # faster completion
      autowrite = true;
      confirm = true;
      clipboard = "unnamedplus";
      cursorline = true;
      shiftround = true;
      signcolumn = "yes";

      ignorecase = true;
      undofile = true; # Build-in persistent undo
      undolevels = 10000;
      conceallevel = 2;
    };

  };
}
