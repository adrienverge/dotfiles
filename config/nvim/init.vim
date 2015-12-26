" Bootstrapping
" =============
"
" mkdir -p ~/.config/nvim/bundle
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
"
" :PluginList
" :PluginInstall

set nocompatible
filetype off

set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'bling/vim-airline'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/autoload_cscope.vim'
Plugin 'klen/python-mode'
Plugin 'tpope/vim-fugitive'
Plugin 'benekastah/neomake'
Plugin 'airblade/vim-gitgutter'

call vundle#end()
filetype plugin indent on

" Conf: general vim
" ==================

" Display
set number
"set ruler

" Search
set hlsearch
set smartcase

" Tabs
set shiftwidth=8
set softtabstop=8
set tabstop=8

" Syntax
syntax on

set mouse=

" Text width
autocmd BufReadPost,BufNewFile *
	\ if &l:textwidth == 0 | setlocal textwidth=80 | endif
  \ | execute "setlocal colorcolumn=" . &l:textwidth
highlight ColorColumn ctermbg=233

" No auto indenting during copy-paste, but no auto-formatting
"set paste

set clipboard+=unnamedplus

if has("autocmd")
  " Replace cursor at same position upon next editing
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \ | exe "normal! g'\"" | endif
  " Special indentings
  "au BufNewFile,BufRead *.py setf python
  au BufNewFile,BufRead *.h setlocal filetype=c
  au FileType c setlocal cindent noexpandtab foldmethod=syntax
  au FileType python setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
  au FileType tex,html,yaml,sh,zsh
  \ setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  au FileType javascript,json
  \ setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
  " Auto-correcting .tex files
  "augroup filetypedetect
  "au BufNewFile,BufRead *.tex setlocal spell spelllang=fr
  "augroup END
endif

" Tab-completing for opening files
"set wildmode=longest,list,full
"set wildmenu

" Buffer shortcuts
" <Tab><Tab><Tab>  shows buffers
" <Tab><Tab>j  moves to next buffer
" <Tab><Tab>k  moves to previous buffer
" <Tab><Tab>3  moves to buffer 3
map <Tab><Tab><Tab>  :ls<CR>
map <Tab><Tab>j      :bn<CR>
map <Tab><Tab>k      :bp<CR>
map <Tab><Tab>1      :b 1<CR>
map <Tab><Tab>2      :b 2<CR>
map <Tab><Tab>3      :b 3<CR>
map <Tab><Tab>4      :b 4<CR>
map <Tab><Tab>5      :b 5<CR>
map <Tab><Tab>6      :b 6<CR>
map <Tab><Tab>7      :b 7<CR>
map <Tab><Tab>8      :b 8<CR>
map <Tab><Tab>9      :b 9<CR>
" 3<Tab><Tab>  moves to buffer 3
"nnoremap <Tab><Tab> :<C-U>exe "b" v:count1<CR>

" Possible to leave modified buffers
set hidden

" Conf: plugins
" =============

" vim-airline
" -----------

" font installation :
" https://powerline.readthedocs.org/en/latest/installation/linux.html#fonts-installation

let g:airline_theme = 'powerlineish'

set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" The NERD tree
" -------------

map <F4> :NERDTreeToggle<CR>

" Cscope
" ------

if has("cscope")
  set cscopetag cscopeverbose
  nnoremap <C-c>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  nnoremap <C-c>s :cs find s <C-R>=expand("<cword>")<CR><CR>
endif

" EasyMotion
" ----------

map <Tab>w <Plug>(easymotion-bd-w)
map <Tab>W <Plug>(easymotion-bd-W)
map <Tab>b <Plug>(easymotion-bd-w)
map <Tab>B <Plug>(easymotion-bd-W)
map <Tab>e <Plug>(easymotion-bd-e)
map <Tab>E <Plug>(easymotion-bd-E)
map <Tab>f <Plug>(easymotion-bd-f)
map <Tab>s <Plug>(easymotion-s2)

map <Tab>h <Plug>(easymotion-linebackward)
map <Tab>j <Plug>(easymotion-j)
map <Tab>k <Plug>(easymotion-k)
map <Tab>l <Plug>(easymotion-lineforward)
let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion

"map  / <Plug>(easymotion-sn)
"omap / <Plug>(easymotion-tn)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)

" python-mode
" -----------

let g:pymode_rope_goto_definition_cmd = 'e'
let g:pymode_rope_lookup_project = 1
let g:pymode_lint_cwindow = 0
set completeopt=menu " Disable auto documentation in a new window

" Neomake (previously syntastic)
" ------------------------------

autocmd BufWritePost * Neomake
hi NeomakeError ctermbg=black ctermfg=1
hi NeomakeWarning ctermbg=black ctermfg=11
let g:neomake_error_sign = { 'texthl': 'NeomakeError' }
let g:neomake_warning_sign = { 'texthl': 'NeomakeWarning' }

if executable('./node_modules/.bin/eslint')
  let g:neomake_javascript_eslint_exe = './node_modules/.bin/eslint'
  let g:neomake_javascript_enabled_makers = ['eslint']
elseif executable('eslint')
  let g:neomake_javascript_eslint_exe = 'eslint'
  let g:neomake_javascript_enabled_makers = ['eslint']
endif

" vi: ts=2 sw=2
