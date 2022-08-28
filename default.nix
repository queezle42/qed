{ pkgs, extraRC ? "", extraStartPlugins ? [], extraOptPlugins ? [] }:

let
  vim-godot = pkgs.vimUtils.buildVimPlugin {
    name = "vim-godot";
    src = pkgs.fetchFromGitHub {
      owner = "habamax";
      repo = "vim-godot";
      rev = "c68ce5504fa64b31a5bc3029460faa84f84b598c";
      sha256 = "sha256-Fvoh4Z1T8yr19kTqg0YG9xHBVibdFyWtIcSFB9TEQ7c=";
    };
  };
  vim-tidal = pkgs.vimUtils.buildVimPlugin {
    name = "vim-tidal";
    src = pkgs.fetchFromGitHub {
      owner = "tidalcycles";
      repo = "vim-tidal";
      rev = "1.4.8";
      sha256 = "sha256-c12v9+s/JspQ9Am291RFI7eg0UAeXGDvJ5lK+7ukOb0=";
    };
    patchPhase = "rm Makefile";
  };
in
pkgs.neovim.override {
  configure = {
    customRC = ''
      source ${./init.vim}
      source ${./init.lua}

      ${extraRC}
    '';
    packages.myVimPackage = with pkgs.vimPlugins; {
      start = [
        # Library
        plenary-nvim

        # Colorscheme
        #gruvbox-nvim
        kanagawa-nvim
        gruvbox-community
        tokyonight-nvim

        # Distraction-free writing in Vim.
        goyo-vim

        # Basics (VSCodeVim compatible)
        # Changes 's<char><char>' to motion that finds the next combination of the given characters (similar to 'f<char>')
        #vim-sneak
        # sneak + easymotion hybrid
        lightspeed-nvim
        # Various commands that add, change and remove brackets, quotes and tags.
        vim-surround
        # Jump to any location by showing helper marks.
        vim-easymotion

        # Provides hook that allows other plugins to register repeat actions ('.')
        vim-repeat
        # Increment and decrement dates and times with <Ctrl-A> and <Ctrl-X>
        vim-speeddating

        # Mark whitespace red
        vim-better-whitespace

        # Multi-cursor. <C-n> to start/add cursor on next match, <C-x> to skip match, <C-p> to undo cursor, <A-n> to select all matches.
        vim-multiple-cursors

        # Fuzzy finder
        telescope-nvim
        telescope-ui-select-nvim
        telescope-symbols-nvim
        telescope-fzf-native-nvim

        #fzfWrapper
        #fzf-vim

        which-key-nvim

        # neovim native language server support
        nvim-lspconfig
        trouble-nvim
        #nvim-lightbulb

        # rust cargo crate support
        crates-nvim

        lsp_lines-nvim

        # Show lsp status and log in the corner
        fidget-nvim

        # Completion
        nvim-cmp
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        cmp_luasnip

        # Snippets
        luasnip

        # treesitter
        (nvim-treesitter.withPlugins (
          plugins: with plugins; [
            tree-sitter-haskell
            tree-sitter-nix
            tree-sitter-lua
            tree-sitter-python
            tree-sitter-rust
            tree-sitter-c
            tree-sitter-cpp
            tree-sitter-zig
            tree-sitter-json
            tree-sitter-yaml
            tree-sitter-toml
            tree-sitter-html
            tree-sitter-css
            tree-sitter-scss
            tree-sitter-javascript
            tree-sitter-latex
            tree-sitter-bibtex
            tree-sitter-markdown
            tree-sitter-gdscript
            tree-sitter-godot-resource
            tree-sitter-dockerfile
          ]
        ))
        playground

        # treesitter-based dimming of inactive code
        twilight-nvim

        # highlight other occurences of the word under the cursor
        #vim-illuminate

        nvim-gdb

        vim-highlightedyank
        #vim-numbertoggle

        # A Vim plugin which shows a git diff in the 'gutter' (sign column).
        #vim-gitgutter
        gitsigns-nvim

        # NERDTree
        nerdtree

        # Better status bar
        vim-airline

        bufferline-nvim

        # Nix syntax highlighting
        vim-nix

        # Haskell syntax highlighting
        #haskell-vim

        # Godot
        vim-godot

        # music livecoding
        vim-tidal
      ] ++ extraStartPlugins;
      opt = [
      ] ++ extraOptPlugins;
    };
  };
}
