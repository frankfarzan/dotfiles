" Setup Vundle:
" Install the vundle plugin manually:
" https://github.com/gmarik/vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

"=========================
call vundle#begin()
"=========================
" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Snippets
" Track the engine.
Plugin 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'
" Trigger configuration. Do not use <tab> if you use
" https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" Defines my private snippet directory which is versioned.
let g:UltiSnipsSnippetsDir="~/.vim/myUltiSnips"
let g:UltiSnipsSnippetDirectories = ['myUltiSnips']

" Go plugin
Plugin 'fatih/vim-go'
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_auto_sameids = 1

"=========================
call vundle#end()
"=========================

" We have to turn this stuff back on if we want all of our features.
filetype plugin indent on " Filetype auto-detection
syntax on " Syntax highlighting

set bg=dark                     " I like dark backgrounds
set ttyfast                     " Indicate fast terminal conn for faster redraw
set laststatus=1                " Show status line iff 2+ windows
set modeline                    " Allow file-embedded modelines
set hlsearch                    " Highlight search terms
set showcmd                     " Show last command
set completeopt=menuone         " Show insertion menu for completions
set tabstop=4                   " Tab width
set shiftwidth=4                " How much to shift text
set expandtab                   " Tabs are converted to spaces
set ai                          " Auto-indent
syn on                          " Syntax highlighting
set textwidth=78                " Default text width
set backspace=indent,eol,start  " Makes backspace key more powerful
set autowrite                   " Automatically save before :next, :make etc.

" markdown
au BufRead,BufNewFile *.md set filetype=markdown

" go
au FileType go setl tabstop=4
au FileType go setl shiftwidth=4
au FileType go setl textwidth=1000
au FileType go setl number
au FileType go setl nolist

" yaml
au FileType yaml setl indentkeys-=<:>
au FileType yaml setl tabstop=2
au FileType yaml setl shiftwidth=2
au FileType yaml setl expandtab
au FileType yaml setl number

" Bindings for easy split nav
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" New files should open in insert mode
au BufNewFile * startinsert

colorscheme desert
