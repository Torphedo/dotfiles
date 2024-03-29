" Give ourselves line numbers & incremental search
set nu
set rnu
set incsearch

" QoL indentation settings
set smartindent
set autoindent

set completeopt+=menuone,noselect,noinsert

" 4 space tabs
let indentsize=4 " This variable controls tab size for everything
let &tabstop=indentsize
let &softtabstop=indentsize
let &shiftwidth=indentsize

set expandtab " Make tabs into spaces

" Use a persistent undo file and no swap file.
set noswapfile
set nobackup
set undodir="~/.vim/undodir"
set undofile

if has('win32') || has ('win64')
    let $VIMHOME = $VIM."/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif

" Enable system clipboard support
set clipboard+=unnamedplus

" Color bar at column 80 to remind us to keep code width short
set cc=80

" Enable solarized dark color scheme in degraded 256 color mode
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

" Enable syntax and plugins (for netrw)
syntax enable
filetype plugin on

set laststatus=2 " Always show statusline

let g:currentmode={
   \ 'n'  : 'NORMAL',
   \ 'v'  : 'VISUAL',
   \ 'V'  : 'V-Line',
   \ "\<C-V>" : 'V-Block',
   \ 'i'  : 'INSERT',
   \ 'R'  : 'REPLACE',
   \ 'Rv' : 'V-Replace',
   \ 'c'  : 'COMMAND',
\}

" Custom statusline.
set statusline=%#StatusLineTermNC#\ %{g:currentmode[mode()]}\ 
set statusline+=%#StatusLineNC# " Dark bar color
set statusline+=\ %f\  " Filename
set statusline+=%h%m%r " Mode flags (like RO, [+], [-])

set statusline+=%= " Start right side
set statusline+=%#StatusLine# " Lighter color for emphasis
set statusline+=%y\  " Filetype
set statusline+=%3(%p%)%-2(%%%) " Percentage
set statusline+=%#StatusLineTermNC# " Green bar for line & column
set statusline+=%5(%l%):%-3(%c%) " Line number and column, centered, 8 wide

" Use a line cursor within insert mode and a block cursor everywhere else.

" 2  -> steady block.
" 3  -> blinking underline.
" 6  -> steady bar (xterm).
let &t_SR = "\e[3 q"
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" Remove a weird delay after leaving insert mode before restoring block cursor
set ttimeout
set ttimeoutlen=1

let g:netrw_banner=0
let g:netrw_liststyle=3

" Custom keybinds.
" ==============================

" Make space our leader key
let mapleader=" "

" Shortcuts for window splits
" nnoremap _ :sp<CR>
nnoremap <Bar> :vsp<CR>

" Window navigation shortcuts
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader><C-H> <C-w>H
nnoremap <leader><C-J> <C-w>J
nnoremap <leader><C-K> <C-w>K
nnoremap <leader><C-L> <C-w>L

" Shift-J / Shift-K in visual line mode to move lines around
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Make searching and paging center the screen
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" Keep cursor at start when joining lines
nnoremap J J0

" Search-replace
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" Fugitive keybindings
nnoremap <leader>gg :Git<CR>
" Add current file to git (git add [current file])
nnoremap <leader>ga :Gwrite<CR>
nnoremap <leader>gw :Gwrite<CR>
" This is named "gc" as in "git commit" to distinguish from "git remove".
nnoremap <leader>gc :Gread<CR>
nnoremap <leader>gr :Gremove<CR>
" We assume remote name is main here, maybe not the best.
nnoremap <leader>gp :Git push<CR>

" Leader + e (for "explore") to open netrw.
nnoremap <leader>e :Ex<CR>

" LaTeX shortcuts
" Run ~/.vim/latex.sh, passing the current file as an argument.
nnoremap <leader>ll :execute ("!".expand("$VIMHOME")."/latex.sh ".expand("%"))<CR><CR>

" Open PDF build of tex file in local PDF viewer.
nnoremap <leader>lv :!zathura out/%:r.pdf --fork<CR><CR>
" Strip tex file of commands and word-count it
nnoremap <leader>lc :!detex % \| wc -w<CR>
" Open PDF build of tex file in browser
nnoremap <leader>lb :!firefox out/%:r.pdf<CR><CR>

" Spellcheck keybinds
nnoremap <leader>sp :setlocal spell spelllang=en_us<CR>

" Shortcut to use clipboard
nnoremap <leader>p "+p
nnoremap <leader>y "+y

nnoremap <leader>x :!chmod +x %<CR><CR>:redr!<CR>

