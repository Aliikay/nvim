{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {nixpkgs, ...} @ inputs: {
    packages.x86_64-linux = {
      # Set the default package to the wrapped instance of Neovim.
      # This will allow running your Neovim configuration with
      # `nix run` and in addition, sharing your configuration with
      # other users in case your repository is public.
      default =
        (inputs.nvf.lib.neovimConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            {
              config.vim = {
                # Options
                options = {
                  tabstop = 4; # Number of spaces a <Tab> counts for
                  shiftwidth = 4; # Number of spaces for autoindent (>>, <<, etc.)
                  expandtab = true; # Use spaces instead of tabs
                  autoindent = true; # Copy indent from current line when starting a new line
                  smartindent = true; # Smart autoindent (improves on autoindent for code)
                  softtabstop = 4; # Number of spaces for <Tab> in insert mode (backspace deletes 4 spaces)
                };

                # Enable custom theming options
                theme = {
                  enable = true;
                  name = "gruvbox";
                  style = "dark";
                };

                # Enable diagnostics
                diagnostics = {
                  enable = true;
                  config = {
                    update_in_insert = true;
                    virtual_text = true;
                  };
                };

                # Enable Treesitter
                treesitter.enable = true;

                # Language options
                languages = {
                  enableFormat = true;
                  enableTreesitter = true;

                  rust.enable = true;
                  nix.enable = true;
                  python.enable = true;
                  markdown.enable = true;
                  html.enable = true;
                  css.enable = true;
                  bash.enable = true;
                  csharp.enable = true;
                };

                # LSP Options
                lsp = {
                  enable = true;
                  formatOnSave = true;
                  lspSignature.enable = true;
                  trouble.enable = true;
                };

                telescope = {
                  enable = true;
                  mappings = {
                    findFiles = "<C-p>";
                  };
                };

                # Statusline
                statusline = {
                  lualine = {
                    enable = true;
                    theme = "gruvbox";
                  };
                };

                # Autocomplete
                autocomplete = {
                  nvim-cmp.enable = true;
                };

                # Filetree
                filetree = {
                  nvimTree = {
                    enable = true;
                    mappings.toggle = "<C-e>";
                  };
                };
              };
            }
          ];
        }).neovim;
    };
  };
}
