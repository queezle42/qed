{ pkgs, extraRC ? "", extraStartPlugins ? [], extraOptPlugins ? [] }:

let
  vim-godot = pkgs.vimUtils.buildVimPlugin {
    pname = "vim-godot";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "habamax";
      repo = "vim-godot";
      rev = "c68ce5504fa64b31a5bc3029460faa84f84b598c";
      sha256 = "sha256-Fvoh4Z1T8yr19kTqg0YG9xHBVibdFyWtIcSFB9TEQ7c=";
    };
  };
  vim-tidal = pkgs.vimUtils.buildVimPlugin rec {
    pname = "vim-tidal";
    version = "1.4.8";
    src = pkgs.fetchFromGitHub {
      owner = "tidalcycles";
      repo = "vim-tidal";
      rev = version;
      sha256 = "sha256-c12v9+s/JspQ9Am291RFI7eg0UAeXGDvJ5lK+7ukOb0=";
    };
    patchPhase = "rm Makefile";
  };
  leap-spooky-nvim = pkgs.vimUtils.buildVimPlugin rec {
    pname = "leap-spooky-nvim";
    version = "unstable";
    src = pkgs.fetchFromGitHub {
      owner = "ggandor";
      repo = "leap-spooky.nvim";
      rev = "3e940464b1728b22052dd565accc949c0b02b025";
      sha256 = "sha256-mkbfGTSLCB2Srjjk3FfacP7HazxwSW0F/7AOfp/vv/g=";
    };
  };
in
pkgs.neovim.override {
  configure = {
    customRC = ''
      source ${./init.vim}
      source ${./init.lua}

      lua << EOF
        local haskell_highlight_grammar_file = io.open("${./tree-sitter-haskell/highlights.scm}")
        local haskell_highlight_grammar = haskell_highlight_grammar_file:read('a')
        haskell_highlight_grammar_file:close()

        require("vim.treesitter.query").set_query("haskell", "highlights", haskell_highlight_grammar)
      EOF

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

        # 's' jump (sneak with addidional label / lightspeed replacement)
        leap-nvim
        leap-spooky-nvim
        # Various commands that add, change and remove brackets, quotes and tags.
        vim-surround
        # Jump to any location by showing helper marks.
        vim-easymotion

        comment-nvim

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

        # rust cargo crate support
        crates-nvim

        # Diagnostics UI
        trouble-nvim
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

        # Highlight long lines
        # TODO Not packaged in nixpkgs
        #overlength-nvim

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

        nvim-web-devicons

        nvim-tree-lua

        # Better status bar
        lualine-nvim

        bufferline-nvim
        bufdelete-nvim

        # Nix syntax highlighting
        vim-nix

        # Web development
        vim-svelte

        # Haskell syntax highlighting
        #haskell-vim

        # Godot
        vim-godot

        # GLSL shader (.glsl, .frag, .vert, ...)
        vim-glsl

        # music livecoding
        vim-tidal
      ] ++ extraStartPlugins;
      opt = [
      ] ++ extraOptPlugins;
    };
  };
}
