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

Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'scrooloose/nerdtree'
Plugin 'vim-scripts/autoload_cscope.vim'
Plugin 'python-mode/python-mode'
Plugin 'tpope/vim-fugitive'
Plugin 'benekastah/neomake'
Plugin 'airblade/vim-gitgutter'
Plugin 'rust-lang/rust.vim'
Plugin 'vivien/vim-linux-coding-style'
Plugin 'leafgarland/typescript-vim'
Plugin 'mhartington/nvim-typescript'
Plugin 'Shougo/deoplete.nvim'
Plugin 'Shougo/denite.nvim'
Plugin 'digitaltoad/vim-pug'
Plugin 'Konfekt/FastFold'
Plugin 'tmhedberg/SimpylFold'

call vundle#end()
filetype plugin indent on

" Conf: general vim
" ==================

" Coloscheme
colorscheme gruvbox
set background=light
let g:gruvbox_contrast_light = 'hard'

" Display
set number
"set ruler

" Search
set hlsearch
set smartcase
set scrolloff=5

" Tabs
set shiftwidth=8
set softtabstop=8
set tabstop=8

" Syntax
syntax on
highlight Search ctermbg=226
highlight Todo ctermbg=226

set mouse=

" Text width
autocmd BufReadPost,BufNewFile *
  \ if &l:textwidth == 0 | setlocal textwidth=80 | endif
  \ | execute "setlocal colorcolumn=" . &l:textwidth
highlight ColorColumn ctermbg=15

" No auto indenting during copy-paste, but no auto-formatting
"set paste

set clipboard=unnamedplus

" Replace cursor at same position upon next editing
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
\ | exe "normal! g'\"" | endif
" Special indentings
"autocmd BufNewFile,BufRead *.py setf python
autocmd BufNewFile,BufRead *.h setlocal filetype=c
autocmd FileType c setlocal cindent noexpandtab foldmethod=syntax
autocmd FileType python setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
autocmd FileType tex,html,pug,css,yaml,sh,zsh
\ setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
autocmd FileType javascript,json,typescript
\ setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
" Auto-correcting .tex files
"augroup filetypedetect
"autocmd BufNewFile,BufRead *.tex setlocal spell spelllang=fr
"augroup END
autocmd BufNewFile,BufRead *.plt,*.gnuplot set filetype=gnuplot
autocmd BufNewFile,BufRead */{group,host}_vars/* set filetype=yaml

" Tab-completion for completing command (e.g. opening files)
set wildmenu
set wildmode=longest:full,full

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

" font installation : `sudo dnf install powerline-fonts`, then restart Wayland

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
  autocmd FileType c nnoremap <buffer> <C-c>g :cs find g <C-R>=expand("<cword>")<CR><CR>
  autocmd FileType c nnoremap <buffer> <C-c>s :cs find s <C-R>=expand("<cword>")<CR><CR>
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

let g:pymode_python = 'python3'
" For it to work: pip3 install --user neovim

let g:pymode_rope = 1
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_goto_definition_cmd = 'e'
let g:pymode_lint_cwindow = 0
set completeopt=menu " Disable auto documentation in a new window

let g:pymode_lint = 0

" Use 'tmhedberg/SimpylFold' which is much better for folding, but keep
" python-mode folding text
let g:pymode_folding = 0
" Change folding labels (but freezes Nvim with some .py files):
"autocmd FileType python setlocal foldtext=pymode#folding#text()

" Neomake (previously syntastic)
" ------------------------------

autocmd BufWritePost * Neomake
hi NeomakeError ctermbg=none ctermfg=1
hi NeomakeWarning ctermbg=none ctermfg=11
let g:neomake_error_sign = { 'texthl': 'NeomakeError' }
let g:neomake_warning_sign = { 'texthl': 'NeomakeWarning' }

if executable('./node_modules/.bin/eslint')
  let g:neomake_javascript_eslint_exe = './node_modules/.bin/eslint'
  let g:neomake_javascript_enabled_makers = ['eslint']
elseif executable('eslint')
  let g:neomake_javascript_eslint_exe = 'eslint'
  let g:neomake_javascript_enabled_makers = ['eslint']
endif

" nvim-typescript
" ---------------
" Needs:
" pip3 install --user neovim
" sudo npm install -g neovim
" cd ~/.vim/bundle/nvim-typescript; ./install.sh
" :UpdateRemotePlugins

let g:deoplete#enable_at_startup = 1
autocmd FileType typescript nnoremap <buffer> <C-c>g :TSDef<CR>

" vi: ts=2 sw=2
