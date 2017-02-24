" My vim settings file
" Author: Mskadu <mskadu@gmail.com>
" Last updated: 10/09/2015
"

" Settings {{{
set secure nocompatible
if version >= 600
  syntax enable

  if version >= 700
    filetype plugin indent on
  else
    filetype on
    filetype plugin on
    filetype indent on
  endif
else
  :finish
endif
" }}}


" General Settings {{{
"
"Make autoindent happen
set autoindent
"Show actual cursor position
set ruler
set showcmd
set showmatch
set showmode

"Misc
set backspace=indent,eol,start
set formatoptions=croq
set number
set shiftwidth=2
set smartindent
set tabstop=2
set expandtab

" *always* use Unicode
set encoding=utf-8 fileencodings=

"Fix findstr for Win32
if has("win32")
  set grepprg=findstr\ /R\ /S\ /N
endif

" Choose right syntax highlighting with tab completion
map <F2> :source $VIMRUNTIME/syntax/
" F9 toggles highlighting
map <F9> :if has("syntax_items")<CR>syntax off<CR>else<CR>syntax on<CR>endif<CR><CR>

"Vim 7 specific mappings
if version >= 700
  map <C-t> <Esc>:tabnew<CR>
  map <C-F4> <Esc>:tabclose<CR> 
  map <C-a> <Esc>ggVG 
endif

"Windows like mappings
if has("win32")
  "Ctrl+A = Select All
  map <C-a> <Esc>ggVG 
  "Ctrl+tab = Fwd Cycle across splits
  map <C-Tab> <Esc><C-w>w
  "Ctrl+Shift+tab = Reverse Cycle across splits
  map <C-S-Tab> <Esc><C-w>W
endif

"Get working with Unicode (source: http://vim.wikia.com/wiki/Working_with_Unicode)
if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif


" show status line
set ls=2
" modify status line to show charcode at cursor 
" source: http://vim.wikia.com/wiki/Showing_the_ASCII_value_of_the_current_character
set statusline=%<%f%h%m%r%=%b\ 0x%B\ \ %l,%c%V\ %P

"Make no *.bak
set nobackup
" keep backup while we are editing
set writebackup
"Do not wrap text
set nowrap
" do not highlight searches
set nohlsearch
"Turn this ON when we want to debug
"set verbose=9

"General Options ends }}}

"Java settings {{{
let java_highlight_functions=1

if has("autocmd")
  autocmd BufRead,BufNewFile *.java set makeprg=javac\ %
  "autocmd BufRead BufNewFile *.java set makeprg=ant\ -emacs

  " Reload settings file everytime its written 
  " Note: replace $VIM/.vimrc with wherever your vimrc lives
  autocmd! bufwritepost _vimrc source $VIM/_vimrc
  autocmd! bufwritepost .vimrc source $VIM/.vimrc

  " Shameless stolen from vimrc_example. I like this!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

endif
"Java Settings End }}}

"My color settings {{{
"
"Reset the default ones before we begin loading ours
highlight Constant  NONE
highlight Delimiter NONE
highlight Directory   NONE
highlight Error   NONE
highlight ErrorMsg  NONE
highlight Identifier  NONE
highlight LineNr    NONE
highlight ModeMsg   NONE
highlight MoreMsg   NONE
highlight NonText   NONE
highlight Normal    NONE
highlight PreProc   NONE
highlight Question  NONE
highlight Search    NONE
highlight Special   NONE
highlight SpecialKey  NONE
highlight Statement NONE
highlight StatusLine  NONE
highlight Title   NONE
highlight Todo      NONE
highlight Type      NONE
highlight Visual    NONE
highlight WarningMsg  NONE

"Now put in our own colors
highlight Comment   term=bold ctermfg=5 ctermbg=0 guifg=#FF005F guibg=gray
highlight Constant  term=underline ctermfg=6 guifg=#FF2F8F
highlight Delimiter   term=bold cterm=bold ctermfg=1 gui=bold guifg=red
highlight Directory term=bold ctermfg=DarkBlue guifg=Blue
highlight Error   term=standout cterm=bold ctermbg=1 ctermfg=1 gui=bold guifg=red
highlight ErrorMsg  term=standout cterm=bold ctermfg=1 gui=bold guifg=red
highlight Identifier  term=underline ctermfg=3 guifg=Yellow3
highlight LineNr    term=underline cterm=bold ctermfg=3 guifg=Brown
highlight ModeMsg   term=bold cterm=bold ctermfg=3 ctermbg=1 guifg=yellow2 guibg=red
highlight MoreMsg   term=bold cterm=bold ctermfg=2 gui=bold guifg=green
highlight NonText   term=bold ctermfg=2 guifg=green3
highlight Normal    ctermfg=white ctermbg=black guifg=grey90 guibg=#000020
highlight PreProc   term=underline ctermfg=14 guifg=cyan
highlight Question  term=standout cterm=bold ctermfg=2 gui=bold guifg=Green
highlight Search    term=reverse ctermbg=2 guibg=Yellow
highlight Special   term=bold ctermfg=5 guifg=SlateBlue
highlight SpecialKey  term=bold ctermfg=DarkBlue guifg=Blue

"set foldmethod=indent
"colorscheme darkblue
colorscheme desert

"use our custom font
if has("gui") 
  if has("win32")
    "This font looks more suitable on Windows
    set guifont=Courier_New:h9:cANSI
  endif

  "see: http://vim.wikia.com/wiki/VimTip1
  set mousemodel=extend
endif

" Custom Commands
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis

"highlight current line
set cursorline
":hi CursorLine term=none cterm=none ctermbg=3
":autocmd InsertLeave * hi CursorLine term=none cterm=none ctermbg=3
":autocmd InsertEnter * hi CursorLine term=none cterm=none ctermbg=4
