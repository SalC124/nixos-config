{ ... }: {
  config = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = [
      {
        mode = [
          "n"
          "i"
        ];
        key = "<esc>";
        action = "<cmd>noh<cr><esc>";
        options = {
          silent = true;
          desc = "Escape and clear hlsearch";
        };
      }
      {
        mode = [ "n" ];
        key = "<leader>n";
        action = "<cmd>Neotree toggle<cr>";
      }
      {
        mode = [ "n" ];
        key = "<leader>h";
        action = "<C-w>h";
        options.desc = "Move left";
      }
      {
        mode = [ "n" ];
        key = "<leader>j";
        action = "<C-w>j";
        options.desc = "Move down";
      }
      {
        mode = [ "n" ];
        key = "<leader>k";
        action = "<C-w>k";
        options.desc = "Move up";
      }
      {
        mode = [ "n" ];
        key = "<leader>l";
        action = "<C-w>l";
        options.desc = "Move right";
      }
      {
        mode = "n";
        key = "<leader>ut";
        action = "<cmd>UndotreeToggle<CR>";
        options = {
          silent = true;
          desc = "Undotree";
        };
      }
      {
        key = "<leader>f";
        action = "<cmd> FormatOnce <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Format File";
        };
      }
      {
        key = "<leader>Rf";
        action = "<cmd> RustFmt <CR>";
        mode = "n";
        options = {
          silent = true;
          desc = "Format File";
        };
      }

    ];
  };
}
