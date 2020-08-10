set number relativenumber
set laststatus=2
set showcmd                           " show commands
set encoding=utf-8
set gdefault                          " apply substitute globally
set ignorecase
set smartcase

set tabstop=4		                  " number of visual spaces per tab
set softtabstop=4	                  " number of spaces in tab when editing
set shiftwidth=4                      " number of spaces when shifting with >
set expandtab		                  " tabs are spaces

set clipboard+=unnamedplus	          " enable copying to clipboard
filetype indent on	                  " load filetype specific indent files

set foldmethod=syntax
set foldlevelstart=10

set splitbelow                        " more natural split opening
set splitright

set lazyredraw
set inccommand=nosplit                " live substitute


"-----------vim-plug-------------"
call plug#begin()
Plug 'itchyny/lightline.vim'
Plug 'cocopon/lightline-hybrid.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'suy/vim-context-commentstring'
Plug 'scrooloose/nerdtree', {'on' : 'NERDTreeToggle'}
Plug 'sheerun/vim-polyglot'
Plug 'styled-components/vim-styled-components', {'branch' : 'main'}
Plug 'jparise/vim-graphql'
Plug 'mattn/emmet-vim', {'for': ['html', 'javascript ', 'php', 'css']}
Plug 'ctrlpvim/ctrlp.vim'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'w0ng/vim-hybrid'
Plug 'joshdick/onedark.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine', {'for': ['blade', 'html', 'js', 'javascript.jsx']}
Plug 'ervandew/supertab'
Plug 'AndrewRadev/splitjoin.vim'
call plug#end()


" colorscheme
set termguicolors
colorscheme nord

" ctrlp
let g:ctrlp_open_new_file = 'r'       " open new files in current window
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor,*/node_modules

" react jsx
let g:jsx_ext_required = 0            " Allow JSX in normal js files

" lightline
let g:lightline = {
            \ 'colorscheme': 'nord',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'readonly', 'filename', 'modified' ],
            \             [ 'ctrlpmark' ] ]
            \ },
            \ 'component_function': {
            \    'gitbranch': 'fugitive#head',
            \    'filename': 'MyFilename',
            \    'mode': 'MyMode',
            \    'ctrlpmark': 'CtrlPMark',
            \ },
            \ 'subseparator': { 'left': '|', 'right': '|' },
            \ }

function! MyFilename()
  if expand('%:t') =~ 'ControlP'
    return g:lightline.ctrlp_prev . ' ' . g:lightline.subseparator.left . ' ' .
          \ g:lightline.ctrlp_item . ' ' . g:lightline.subseparator.left . ' ' .
          \ g:lightline.ctrlp_next
  endif
  return ('' != expand('%:t') ? expand('%:t') : '[No Name]')
endfunction

function! MyMode()
    let fname = expand('%:t')
    return fname == 'ControlP' ? 'CtrlP' :
         \ fname =~ 'NERD_tree' ? 'NERDTree' :
         \ winwidth('.') > 60 ? lightline#mode() : ''
endfunction

function! CtrlPMark()
  return expand('%:t') =~ 'ControlP' ? g:lightline.ctrlp_marked : ''
endfunction

function! LightlineModified()
  return (&ft =~ 'help' || &ft =~ 'qf') ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

let g:ctrlp_status_func = {
  \ 'main': 'Function_Name_1',
  \ 'prog': 'Function_Name_2',
  \ }

function! Function_Name_1(focus, byfname, regex, prev, item, next, marked)
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  let g:lightline.ctrlp_marked = a:marked
  return lightline#statusline(0)
endfunction

function! Function_Name_2(...)
    let len = '%#Function# '.a:1.' %*'
	let dir = ' %=%<%#LineNr# '.getcwd().' %*'
	" Return the full statusline
	retu len.dir
endfunction

" emmet
let g:user_emmet_settings={'javascript.jsx': {'extends':'jsx'}}

" key mappings
let mapleader=","

autocmd FileType html,css,php,javascript imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

:imap jj <Esc>

map <leader>k :NERDTreeToggle<CR>
map <leader><space> :nohlsearch<CR>
map <leader>ev :tabedit $MYVIMRC<CR>
map <F9> :make<CR>
map <leader>b :b#<CR>

nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>    " strip trailing whitespace

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" use normal regex
nnoremap / /\v
vnoremap / /\v

augroup configgroup
    autocmd!
    autocmd filetype javascript setlocal tabstop=2
    autocmd filetype javascript setlocal softtabstop=2
    autocmd filetype javascript setlocal shiftwidth=2
    autocmd filetype html setlocal tabstop=2
    autocmd filetype html setlocal softtabstop=2
    autocmd filetype html setlocal shiftwidth=2
    autocmd filetype css setlocal tabstop=2
    autocmd filetype css setlocal softtabstop=2
    autocmd filetype css setlocal shiftwidth=2
augroup end

"hide gvim toolbar
set guioptions-=T
set guioptions-=m

"------------font-----------------"
if has('gui_running')
    set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 13
endif
