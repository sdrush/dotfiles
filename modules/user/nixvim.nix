_:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = false;

    # Global options
    opts = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width
      tabstop = 2;           # Tab width
      expandtab = true;      # Use spaces instead of tabs
      smartcase = true;      # Don't ignore case with capitals
      ignorecase = true;     # Ignore case in search patterns
      mouse = "a";           # Enable mouse support
      termguicolors = true;  # Enable 24-bit RGB colors
      cursorline = true;     # Highlight current line
      scrolloff = 8;         # Minimum lines to keep above/below cursor
    };

    # Keymaps
    globals.mapleader = " ";
    keymaps = [
      # Telescope (Fuzzy Finder)
      { mode = "n"; key = "<leader>ff"; action = "<cmd>Telescope find_files<CR>"; options.desc = "Find Files"; }
      { mode = "n"; key = "<leader>fg"; action = "<cmd>Telescope live_grep<CR>";  options.desc = "Live Grep"; }
      { mode = "n"; key = "<leader>fb"; action = "<cmd>Telescope buffers<CR>";    options.desc = "Buffers"; }
      
      # Neo-tree (File Explorer)
      { mode = "n"; key = "<leader>e";  action = "<cmd>Neotree toggle<CR>";       options.desc = "Toggle Explorer"; }
    ];

    # Plugins
    plugins = {
      # Advanced syntax highlighting
      treesitter.enable = true;

      # Fuzzy finder
      telescope.enable = true;

      # File tree
      neo-tree.enable = true;

      # Statusline
      lualine.enable = true;

      # Icons
      web-devicons.enable = true;

      # Language Server Protocol (LSP)
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;   # Nix
          gopls.enable = true;  # Go
          pyright.enable = true; # Python
          lua_ls.enable = true; # Lua
        };
      };

      # Autocompletion
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          };
        };
      };
    };
    stylix.enable = true;
  };
}