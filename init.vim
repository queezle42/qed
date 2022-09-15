" Configure ' ' as the leader key (would be '\' by default).
let mapleader = " "

" Timeout length, e.g. for which-key
set timeoutlen=800

map ü [
map + ]

" Configure colorscheme
" let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_contrast_light='hard'
" colorscheme gruvbox
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

" Set colorcolumn as a hint to stay within 80 characters per line.
" Other limits might be useful for personal projects, but since this is so
" widely used, 80 is a good default.
" TODO Reading a project-wide override from a file would be useful.
set colorcolumn=81

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

nnoremap <C-p> <Cmd>Telescope find_files<CR>

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
" Project view
nnoremap <Leader>p <Cmd>NERDTreeToggle<CR>

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

nnoremap <Leader>t <Cmd>TroubleToggle<CR>

nnoremap <Leader>go <Cmd>Goyo<CR>

" <Leader>n clears the last search highlighting.
nnoremap <Leader>n <Cmd>nohlsearch<CR>
vnoremap <Leader>n <Cmd>nohlsearch<CR>

" Shortcut to enable spellcheck (requires aspell installation)
nnoremap <Leader>s <Cmd>setlocal spell spelllang=en_us<CR>
nnoremap <Leader>S <Cmd>setlocal spell spelllang=de_de<CR>
