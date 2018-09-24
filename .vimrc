filetype plugin indent on

hi netrwTreeBar guifg=black guibg=black guisp=NONE gui=NONE ctermfg=black ctermbg=black cterm=NONE
hi StatusLine guifg=black guibg=black guisp=NONE gui=NONE ctermfg=white ctermbg=black cterm=NONE
hi EndOfBuffer guifg=black guibg=black guisp=NONE gui=NONE ctermfg=black ctermbg=black cterm=NONE
hi CursorLine guifg=black guibg=black guisp=NONE gui=NONE ctermfg=white ctermbg=black cterm=NONE
hi vimLineComment guifg=black guibg=black guisp=NONE gui=NONE ctermfg=white ctermbg=black cterm=NONE
hi vimHiAttribList guifg=white guibg=black guisp=NONE gui=NONE ctermfg=white ctermbg=black cterm=NONE
hi vimHighlight guifg=white guibg=black guisp=NONE gui=NONE ctermfg=white ctermbg=black cterm=NONE
hi vimCommand guifg=white guibg=black guisp=NONE gui=NONE ctermfg=white ctermbg=black cterm=NONE
hi vimSetSep guifg=white guibg=black guisp=NONE gui=NONE ctermfg=white ctermbg=black cterm=NONE
hi vimOper guifg=white guibg=black guisp=NONE gui=NONE ctermfg=white ctermbg=black cterm=NONE

set runtimepath+=$HOME/.conf
set wildignore+=log/**,tmp/**,target/**,dist/**,.bundle/**,.git/**,node_modules/**
set encoding=utf-8
set fileencodings=utf-8
set fileformats=unix,dos,mac
set nocompatible
set cwh=1
set visualbell t_vb=
set nobackup
set noswapfile
set noerrorbells
set autoread
set hidden
set virtualedit=onemore
set backspace=indent,eol,start
set breakindent
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set hlsearch
set incsearch
set whichwrap=b,s,h,l,<,>,[,]
set ignorecase
set pumheight=10
set foldlevel=200
set clipboard+=unnamed
set laststatus=2
set statusline=%f%m%=\ %{&fenc!=''?&fenc:&enc}
set display=lastline

autocmd BufReadPre syntax on
autocmd FileType netrw setl bufhidden=delete
autocmd QuickFixCmdPost *grep* cwindow

let g:python3_host_prog = expand('/usr/local/bin/python3')
let g:rustfmt_autosave = 1
let g:rustfmt_command = '$HOME/.cargo/bin/rustfmt'
let g:go_fmt_command = "goimports"
let g:go_gocode_unimported_packages = 1
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let mapleader = "\<Space>"
let loaded_matchparen = 1

nnoremap <C-n> :bn<cr>
nnoremap <C-p> :bp<cr>
nnoremap == gg=VG
nnoremap <esc><esc> :nohlsearch<cr>
nnoremap <silent>rr :RustRun<cr>
nnoremap <silent>j gj
nnoremap <silent>k gk
nnoremap <Leader>f :Ex<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>d :bw!<CR>
nnoremap <Leader>w :Gwrite<CR>
nnoremap <Leader>c :Gcommit<CR>
nnoremap <Leader><Leader> :vim  **<left><left><left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
inoremap <C-g> <Left>
vmap <silent> <expr> p <sid>Repl()

function! RestoreRegister()
    let @" = s:restore_reg
    return ''
endfunction

function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction

function! s:remove_line_in_last_line()
    if getline('$') == ""
        $delete _
    endif
endfunction

augroup HighlightTrailingSpaces
    autocmd!
    autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
    autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

call plug#begin('~/.conf/plugged')
Plug 'honza/vim-snippets'
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-fugitive'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'rust-lang/rust.vim'
Plug 'mxw/vim-jsx'
Plug 'Shougo/denite.nvim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

command! SC echo synIDattr(synID(line("."), col("."), 1), "name")
