" Basic settings
set nocompatible              " Use Vim defaults, not vi
set ttyfast                   " Indicate fast terminal connection for faster redraw
set laststatus=1              " Show status line iff more than one window
set modeline                  " Allow file-embedded modelines
set hlsearch                  " Highlight search matches
set showcmd                   " Show incomplete command in the last line
set completeopt=menuone       " Completion menu even with one match
set backspace=indent,eol,start" More powerful backspace
set autowrite                 " Auto-write before :next, :make etc.

" Indentation
set tabstop=4                 " Number of spaces a <Tab> counts for
set shiftwidth=4              " Size of an indent
set expandtab                 " Use spaces instead of tabs
set ai                        " Auto-indent new lines

" Text layout
set textwidth=78              " Line wrap width

" UI
colorscheme desert

" Syntax and filetype
syntax on
filetype plugin indent on     " Enable filetype detection, plugins, and indenting

" File-specific settings
au BufRead,BufNewFile *.md set filetype=markdown

" Go-specific settings
au FileType go setlocal tabstop=4 shiftwidth=4 textwidth=1000 number nolist

" YAML-specific settings
au FileType yaml setlocal indentkeys-=<:> tabstop=2 shiftwidth=2 expandtab number

" Mappings for easier window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Start insert mode in new files
autocmd BufNewFile * startinsert
