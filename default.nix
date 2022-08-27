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
      " Configure ' ' as the leader key (would be '\' by default).
      let mapleader = " "

      " Timeout length, e.g. for which-key
      set timeoutlen=800

      map ü [
      map + ]

      " Configure colorscheme
      let g:gruvbox_contrast_dark='hard'
      let g:gruvbox_contrast_light='hard'
      colorscheme gruvbox
      "hi ColorMagenta guifg='#f92672' guibg=132 guibg='NONE' ctermbg='NONE' gui='NONE' cterm='NONE'
      "hi! link haskellOperators ColorMagenta

      set termguicolors

      " Enable line numbers
      set number
      "set relativenumber

      " Highlight active line (this works well with gruvbox)
      set cursorline

      " Use 2 spaces for indentation
      set shiftwidth=2
      set expandtab
      set shiftround

      " Send the active buffer to the background when opening a file (allows to have unsaved changes in multiple files)
      set hidden

      set smartindent
      filetype plugin indent on

      " Search case-insensitive by default but switch to case-sensitive when using uppercase letters.
      set ignorecase
      set smartcase

      " Full mouse support
      set mouse=a

      " Yank to primary selection.
      " I want to use clipboard=autoselect, when it is implemented: https://github.com/neovim/neovim/pull/3708
      set clipboard=unnamed

      " Wrap at word boundaries instead of splitting words at the end of the line.
      set linebreak

      " Set colorcolumn to nudge me to stay below 100 characters per line
      set colorcolumn=101

      " Shows the effects of a command incrementally, as you type. Also shows partial off-screen results in a preview window.
      set inccommand=split

      " Configure completion: First <tab> completes to the longest common string and also opens the completion menu, following <Tab>s complete the next matches.
      set wildmode=longest:full,full

      " Don't show mode in command line (command line is used by echodoc.vim instead while mode is shown in status bar)
      set noshowmode

      " Setup completion window for nvim-cmp
      set completeopt=menu,menuone,noselect


      " Save with Ctrl-S (if file has changed)
      nnoremap <C-s> <Cmd>update<CR>

      nnoremap <C-p> <Cmd>Files<CR>

      " Use `ALT+{h,j,k,l}` to navigate windows from any mode
      tnoremap <A-h> <C-\><C-N><C-w>h
      tnoremap <A-j> <C-\><C-N><C-w>j
      tnoremap <A-k> <C-\><C-N><C-w>k
      tnoremap <A-l> <C-\><C-N><C-w>l
      inoremap <A-h> <C-\><C-N><C-w>h
      inoremap <A-j> <C-\><C-N><C-w>j
      inoremap <A-k> <C-\><C-N><C-w>k
      inoremap <A-l> <C-\><C-N><C-w>l
      nnoremap <A-h> <C-w>h
      nnoremap <A-j> <C-w>j
      nnoremap <A-k> <C-w>k
      nnoremap <A-l> <C-w>l

      " NERDTree
      " Show hidden files by default
      let g:NERDTreeShowHidden = 1
      " Automaticaly close nvim if NERDTree is only thing left open
      autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
      " Toggle with Alt-b
      nnoremap <a-b> <Cmd>NERDTreeToggle<CR>

      " Airline
      let g:airline#extensions#tabline#enabled = 0

      let g:highlightedyank_highlight_duration = 200

      filetype on

      " Load filetype plugins
      "autocmd FileType nix :packadd vim-nix

      " Bufferline
      nnoremap <silent> gb <Cmd>BufferLinePick<CR>

      " Old language client keybindings
      "  nnoremap <Leader>la <Cmd>call LanguageClient_workspace_applyEdit()<CR>
      "  nnoremap <Leader>lc <Cmd>call LanguageClient#textDocument_definition()<CR>
      "  nnoremap <Leader>ld <Cmd>call LanguageClient#textDocument_definition()<CR>
      "  nnoremap <Leader>le <Cmd>call LanguageClient#explainErrorAtPoint()<CR>
      "  nnoremap <Leader>lf <Cmd>call LanguageClient#textDocument_formatting()<CR>
      "  nnoremap <Leader>lh <Cmd>call LanguageClient#textDocument_hover()<CR>
      "  nnoremap <Leader>lm <Cmd>call LanguageClient_contextMenu()<CR>
      "  nnoremap <Leader>lr <Cmd>call LanguageClient#textDocument_rename()<CR>
      "  nnoremap <Leader>ls <Cmd>call LanguageClient_textDocument_documentSymbol()<CR>
      "  nnoremap <Leader>lt <Cmd>call LanguageClient#textDocument_typeDefinition()<CR>
      "  nnoremap <Leader>lx <Cmd>call LanguageClient#textDocument_references()<CR>
      "  nnoremap <Leader>lq <Cmd>LanguageClientStop<CR><Cmd>LanguageClientStart<CR>


      nnoremap <Leader>go <Cmd>Goyo<CR>

      " <Leader>n clears the last search highlighting.
      nnoremap <Leader>n <Cmd>nohlsearch<CR>
      vnoremap <Leader>n <Cmd>nohlsearch<CR>

      " Shortcut to enable spellcheck (requires aspell installation)
      nnoremap <Leader>s <Cmd>setlocal spell spelllang=en_us<CR>
      nnoremap <Leader>S <Cmd>setlocal spell spelllang=de_de<CR>

      lua << EOF
        -- require("gruvbox").setup({
        --   undercurl = true,
        --   underline = true,
        --   bold = true,
        --   italic = true,
        --   strikethrough = true,
        --   invert_selection = false,
        --   invert_signs = false,
        --   invert_tabline = false,
        --   invert_intend_guides = false,
        --   inverse = true, -- invert background for search, diffs, statuslines and errors
        --   contrast = "", -- can be "hard", "soft" or empty string
        --   overrides = {},
        -- })
        -- vim.cmd([[colorscheme gruvbox]])

        -- Setup nvim-cmp.
        local cmp = require'cmp'

        cmp.setup({
          --snippet = {
          --  -- REQUIRED - you must specify a snippet engine
          --  expand = function(args)
          --    vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
          --    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
          --    -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
          --    -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
          --  end,
          --},
          window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
          },
          mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          }),
          sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            -- { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
          }, {
            { name = 'buffer' },
          })
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype('gitcommit', {
          sources = cmp.config.sources({
            { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
          }, {
            { name = 'buffer' },
          })
        })

        -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline('/', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = {
            { name = 'buffer' }
          }
        })

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          })
        })

        -- Setup lspconfig.
        local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

        local nvim_lsp = require('lspconfig')

        local on_attach = function(client, bufnr)
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
          local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

          -- Enable completion triggered by <c-x><c-o>
          buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Mappings.
          local opts = { noremap=true, silent=true }

          -- See `:help vim.lsp.*` for documentation on any of the below functions
          buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
          buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
          buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
          buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
          buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
          buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
          buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
          buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
          buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
          buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
          buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
          buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
          buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
          buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
          buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
        end

        vim.diagnostic.config({
          virtual_text = false,
          virtual_lines = false,
        })

        nvim_lsp.hls.setup  {
          on_attach = on_attach,
          capabilities = capabilities,
        }
        nvim_lsp.rnix.setup  {
          on_attach = on_attach,
          capabilities = capabilities,
        }
        nvim_lsp.clangd.setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }
        nvim_lsp.rust_analyzer.setup  {
          on_attach = on_attach,
          capabilities = capabilities,
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                buildScripts = {
                  enable = true,
                },
              },
              procMacro = {
                enable = true
              },
            },
          },
        }
        nvim_lsp.gdscript.setup {
          on_attach = on_attach,
          capabilities = capabilities,
        }

        local lsp_lines = require("lsp_lines")
        lsp_lines.setup()
        vim.keymap.set(
          "",
          "<Leader>v",
          lsp_lines.toggle,
          { desc = "Toggle lsp_lines" }
        )

        require("fidget").setup {}

        require('crates').setup()

        require("trouble").setup {
          icons = false,
          padding = false,
          auto_open = true,
          auto_close = true,
        }

        require'nvim-treesitter.configs'.setup {
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
          playground = {
            enable = true,
            --disable = {},
            --updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            --persist_queries = false, -- Whether the query persists across vim sessions
            --keybindings = {
            --  toggle_query_editor = 'o',
            --  toggle_hl_groups = 'i',
            --  toggle_injected_languages = 't',
            --  toggle_anonymous_nodes = 'a',
            --  toggle_language_display = 'I',
            --  focus_language = 'f',
            --  unfocus_language = 'F',
            --  update = 'R',
            --  goto_node = '<cr>',
            --  show_help = '?',
            --},
          }
        }

        require("twilight").setup {}

        require("bufferline").setup {
          highlights = {
            buffer_selected = {
                italic = false,
            },
          };
        }

        -- For a future release
        -- require('illuminate').configure({
        --   -- delay: delay in milliseconds
        --   delay = 0,
        -- })

        --require('nvim-lightbulb').setup({
        --  autocmd = {
        --    enabled = true,
        --    -- see :help autocmd-pattern
        --    pattern = {"*"},
        --    -- see :help autocmd-events
        --    events = {"CursorHold", "InsertLeave"},
        --  }
        --})

        require("which-key").setup {}

        require("gitsigns").setup {}
      EOF

      ${extraRC}
    '';
    packages.myVimPackage = with pkgs.vimPlugins; {
      start = [
        # Library
        plenary-nvim

        # Colorscheme
        #gruvbox-nvim
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
        telescope-symbols-nvim

        fzfWrapper
        fzf-vim

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

        # treesitter
        (nvim-treesitter.withPlugins (
          plugins: with plugins; [
            tree-sitter-haskell
            tree-sitter-nix
            tree-sitter-python
            tree-sitter-rust
            tree-sitter-c
            tree-sitter-cpp
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
