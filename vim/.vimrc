set exrc
set secure
set nocompatible              " be iMproved, required
set smartcase
" filetype off                  " required
filetype plugin on
syntax on
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
set term=xterm-256color
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" For combined usage with tmux and some easier navigation
Plugin 'christoomey/vim-tmux-navigator'
" Gotham color scheme
Plugin 'whatyouhide/vim-gotham'
" For searching text across project folder
Plugin 'mileszs/ack.vim'
" For showing the project tree
Plugin 'scrooloose/nerdtree'
" For some easier text commenting
Plugin 'tpope/vim-commentary'
" For linting
Plugin 'w0rp/ale'
" For showing the file's status in git
Plugin 'airblade/vim-gitgutter'
" For serach
Plugin 'junegunn/fzf'
" For tmux files highlighting
Plugin 'tmux-plugins/vim-tmux'
" Status Line ehancement
Plugin 'itchyny/lightline.vim'
" Tag bar
Plugin 'majutsushi/tagbar'
" Easy motion
Plugin 'easymotion/vim-easymotion'
" Completion engine
Plugin 'ervandew/supertab'
" Golang plugin
Plugin 'fatih/vim-go'
" Local VimRC
Plugin 'embear/vim-localvimrc'
" Smart brackets, quotes etc.
Plugin 'tpope/vim-surround'
Plugin 'jistr/vim-nerdtree-tabs'
" Support engine for linting
Plugin 'xolox/vim-lua-ftplugin'
Plugin 'xolox/vim-lua-inspect'
" Solidity highlighting
Plugin 'tomlion/vim-solidity'
Plugin 'xolox/vim-misc'
" Local VimRC settings
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0
set relativenumber
set gdefault
set background=dark
let g:rehash256 = 1
colorscheme gotham
set t_Co=256
set showbreak=↪\
set list                    " Show whitespace as special chars - see listchars
set listchars=eol:↲,tab:→\ ,extends:›,precedes:‹,nbsp:·,trail:· " Unicode characters for various things
" ALE 
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
let g:ale_linters = {
\   'python': ['flake8'],
\}
" Solidity highlight
autocmd BufNewFile,BufRead *.sol   set syntax=solidity
set noshowmode
let g:ale_echo_msg_error_str = 'E' 
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" FZF keys
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'vsplit',
  \'ctrl-h': 'split'}
" Lightline
let g:lightline = {
\ 'colorscheme': 'gotham',
\ 'active': {
\   'left': [['mode', 'paste'], ['filename', 'modified']],
\   'right': [['lineinfo'], ['percent'], ['readonly', 'linter_warnings', 'linter_errors', 'linter_ok']]
\ },
\ 'component_expand': {
\   'linter_warnings': 'LightlineLinterWarnings',
\   'linter_errors': 'LightlineLinterErrors',
\   'linter_ok': 'LightlineLinterOK'
\ },
\ 'component_type': {
\   'readonly': 'error',
\   'linter_warnings': 'warning',
\   'linter_errors': 'error'
\ },
\ 'component_function': {
\   'mode': 'LightlineMode'
\ },
\ }
function! LightlineMode()
  let fname = expand('%:t')  
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ?  'NERDTree':
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ◆', all_non_errors)
endfunction

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d ✗', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓ ' : ''
endfunction

autocmd User ALELint call s:MaybeUpdateLightline()

" Update and show lightline but only if it's visible (e.g., not in Goyo)
function! s:MaybeUpdateLightline()
  if exists('#lightline')
    call lightline#update()
  end
endfunction Easy motion configs
" ------------------------------------

" <Leader>f{char} to move to {char}
map  sf <Plug>(easymotion-bd-f)
nmap sf <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
" nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map sL <Plug>(easymotion-bd-jk)
nmap sL <Plug>(easymotion-overwin-line)

" Move to word
map  sw <Plug>(easymotion-bd-w)
nmap sw <Plug>(easymotion-overwin-w)
" Done easy motion configs
" ------------------------------------

" Vim-Go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1

" Shortcut for tagbar
map <C-t> :TagbarToggle<CR>

autocmd CompleteDone * pclose

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Local VimRC settings
let g:localvimrc_sandbox = 0
let g:localvimrc_ask = 0

" CTRLP plugin variables
set runtimepath^=~/.vim/bundle/ctrlp.vim

" NERDTree key mappings
map <C-n> :NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_gui_startup = 1
let g:nerdtree_tabs_open_on_console_startup=1
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set number
set tabstop=4
set shiftwidth=2
set softtabstop=2
set expandtab
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set statusline+=%F
set laststatus=2
set cursorline


au BufRead *.c set colorcolumn=80 "show red line
au BufRead *.h set colorcolumn=80 "show red line
au BufRead *.cpp set colorcolumn=80 "show red line
au BufRead *.py set colorcolumn=80 "show red line

" au BufRead *.tex set spell spelllang=en_us " enable spell check
" au BufRead *.txt set spell spelllang=en_us " enable spell check

" To keep the copy buffer between terminal windows
set clipboard=unnamed
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 80 characters.
  autocmd FileType text setlocal textwidth=80

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endiff
" move line without entering Insert mode
nnoremap <C-J> <C-W><C-J> "Ctrl-j to move down a split
nnoremap <C-K> <C-W><C-K> "Ctrl-k to move up a split
nnoremap <C-L> <C-W><C-L> "Ctrl-l to move    right a split
nnoremap <C-H> <C-W><C-H> "Ctrl-h to move left a split
