vim.g.neovide_cursor_animation_length = 0
vim.g.neovide_scroll_animation_length = 0
vim.o.guifont = "Consolas:h11:cANSI"

vim.cmd([[

"autocmd vimenter * NERDTree

"https://github.com/scrooloose/nerdtree
" unzip everything in dir

call plug#begin()

" Access Windows clipboard
map <S-Insert> "+p
imap <S-Insert> <ESC>"+pi

syn on
filetype indent on

"set dir=C:/Users/AGT/AppData/Local/Temp
"set backupdir=C:/Users/AGT/AppData/Local/Temp

set wildoptions=pum

set encoding=utf8
set fileencoding=utf8

set nocompatible
set backspace=indent,eol,start

colorscheme default
set background=light
highlight Normal guibg=#f3f3f3

filetype on             " enable file type detection
syntax on              " syntax highlighting

set ruler
set smartindent  " smart code indentation
set smarttab        " smart tabs
set ignorecase   " ignore la casse
set smartcase    " ignore la casse sauf si une majuscule est entrÃ©e
set laststatus=2 " Affiche le nom du fichier en permanence
set ic
set autowrite

set shiftwidth=4
set softtabstop=4
set tabstop=4
set cindent
set expandtab

set hls

set wildignore=*.o,*.obj,*~,*.pyc,*.aux,*.log
au BufNewFile,BufRead *.json   syn off
au BufNewFile,BufRead *.txt    set filetype=markdown
au BufNewFile,BufRead CMakeLists.txt    set filetype=cmake
set maxmempattern=2000000

map j gj
map k gk
map <f4> :cl<cr>
map <f3> :cn<cr>
map <f2> :cprev<cr>
map ,h :e %:r.h<cr>
map ,c :e %:r.cpp<cr>

set hidden
map <f9> :bprevious<cr>
map <f10> :bnext<cr>
map <f11> :ls<cr>:buffer 

map Q <ESC>

"Netrw config
let g:netrw_liststyle = 3
" let g:netrw_banner = 0
" let g:netrw_browse_split = 4
" let g:netrw_winsize = 17
" let g:netrw_altv = 1
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END


set foldmethod=indent
set nofoldenable

autocmd BufEnter *.m    compiler mlint

set wildmenu

map <F12> :!show %:r<CR>

set scrolloff=3


" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

au BufNewFile,BufRead *.py   set noexpandtab

set grepprg=git\ grep\ -n

"Plug 'https://github.com/ctrlpvim/ctrlp.vim'
"let g:ctrlp_working_path_mode = 'r'

Plug 'https://github.com/editorconfig/editorconfig-vim'

Plug 'https://github.com/neovim/nvim-lspconfig'

Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/junegunn/fzf.vim'
nnoremap <C-p> :<C-u>FZF<CR>

call plug#end()
]])

-- Setup language servers.
local lspconfig = require('lspconfig')
lspconfig.clangd.setup {}
lspconfig.pyright.setup {} -- install server with npm i -g pyright

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
