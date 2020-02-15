set nocompatible              " be iMproved, required

"*****************************************************************************************"
" >>> Plugins
"*****************************************************************************************"

so ~/.vim/plugins.vim


"*****************************************************************************************"
" >>> General Settings
"*****************************************************************************************"

" Enable backspace
set backspace=indent,eol,start

" Disable anoying bell
set noerrorbells visualbell t_vb=

" Convert tabs to space
set expandtab

" Tabs size to 2
set tabstop=2
set shiftwidth=2

" Set auto indentation
set autoindent
set smartindent

" Set auto complete buffers
set complete=.,w,b,u

"auto save files on focus out
set autowriteall

" No new line on EOF
set nofixendofline

" Enable mouse input
set mouse=a

" Unless you're editing huge files, leave this line active.
" This disables the swap file and puts all data in memory.
" Modern machines can handle this just fine, but if you're
" limited on RAM, comment this out.
set noswapfile

" Allow backspace in insert mode
set backspace=indent,eol,start

" Enable code folding by syntax and disable folding by default
setlocal foldmethod=syntax
setlocal nofoldenable

"Persistent undo
set undofile
set undodir=~/.vim/undodir
set undolevels=1000         " How many undos
set undoreload=100        " number of lines to save for undo

"*****************************************************************************************"
" >>> Run shell command and display in a new buffer
"*****************************************************************************************"

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

"*****************************************************************************************"
" >>> Debugger
"*****************************************************************************************"

let g:vdebug_options = {
\ 'break_on_open': 0,
\ 'path_maps': {'/var/www/html/docroot': '/home/dhiroshi/Code/jnjvisionpro/docroot'},
\ 'port': '9000',
\ 'watch_window_style': 'compact'
\ }

let g:vdebug_keymap = {
  \    "run" : "<F5>",
  \    "step_over" : "<F8>",
  \    "step_into" : "<F7>",
  \    "step_out" : "<S-F7>",
  \    "close" : "<S-F5>",
  \    "set_breakpoint" : "<S-F10>",
  \    "eval_under_cursor" : "<S-F12>",
  \ }

"*****************************************************************************************"
" >>> Drupal Settings
"*****************************************************************************************"

if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.inc set filetype=php
    autocmd BufRead,BufNewFile *.profile set filetype=php
    autocmd BufRead,BufNewFile *.view set filetype=php
  augroup END
endif
" Drupal commands
nmap <Leader>cs :Shell phpcs --standard=Drupal,DrupalPractice --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md' %<cr><cr>
nmap <Leader>csf :Shell phpcbf --standard=Drupal,DrupalPractice --extensions='php,module,inc,install,test,profile,theme,css,info,txt,md' %<cr><cr>
nmap <Leader>us :!drush -l us cc all<cr>
nmap <Leader>ca :!drush -l ca cc all<cr>
nmap <Leader>jp :!drush -l jp cc all<cr>

"*****************************************************************************************"
" >>> Visuals
"*****************************************************************************************"

" Enable syntax
syntax enable
syntax on
colorscheme onedark
set cursorline
set relativenumber

" Remove left scrollbar
set guioptions-=l
set guioptions-=L

" Remove menu bar
set guioptions-=m

" Remove toolbar
set guioptions-=T

" Set line numbers
set number
set guifont=JetBrains\ Mono\ 8

" Disable quote concealing in JSON files
let g:vim_json_syntax_conceal = 0

"*****************************************************************************************"
" >>> Searching
"*****************************************************************************************"

" Enable highlight search
set hlsearch
" Enable incremental search
set incsearch
" Enable visual select search
vnoremap // y/<C-R>"<CR>

"*****************************************************************************************"
" >>> Split Management
"*****************************************************************************************"

" enable split window
set splitbelow
set splitright

" Remap split window
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Cycle tabs
" CTRL-Tab is next tab
noremap <C-Tab> :<C-U>tabnext<CR>
inoremap <C-Tab> <C-\><C-N>:tabnext<CR>
cnoremap <C-Tab> <C-C>:tabnext<CR>
" CTRL-SHIFT-Tab is previous tab
noremap <C-S-Tab> :<C-U>tabprevious<CR>
inoremap <C-S-Tab> <C-\><C-N>:tabprevious<CR>
cnoremap <C-S-Tab> <C-C>:tabprevious<CR>

"*****************************************************************************************"
" >>> Plugins
"*****************************************************************************************"

"/
"/ Ctags
"/
nmap <Leader>t :!ctags --file-scope=no -Rf .vscode/tags --tag-relative=yes --langmap=php:.engine.inc.module.theme.install.php --php-kinds=cdfi --recurse --fields=+l --exclude=node_modules --exclude=public --exclude='*.js' --exclude=sites/all/themes/custom/jnj_commerce_theme/gulp --exclude=.git --exclude=sites/ca/files --exclude=sites/jp/files --exclude=sites/us/files --exclude=node_modules
set tags=.vscode/tags
let g:autotagTagsFile=".vscode/tags"

"/
"/ Undo tree
"/
nmap <c-u> :UndotreeToggle<cr><c-h>

"/
"/ Syntastic
"/
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_php_phpcs_args = '--standard=Drupal,DrupalPractice'

"/
"/ Deoplete
"/
let g:deoplete#enable_at_startup = 1
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
" let g:deoplete#ignore_sources.php = ['omni']

"/
"/ Ag
"/
imap <Leader>f <ESC>:Ag 
nmap <Leader>f :Ag 
vmap <Leader>f <ESC>:Ag 

if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
vnoremap <Leader>ag y:Ag <C-R>"<cr>
" Automatically open & close quickfix window
autocmd QuickFixCmdPost [^l]* nested cwindow

"/
"/ Ack
"/
function! PhpImplementations(word)
    exe 'Ack ^[^\n\r\*]*"function.*' . a:word . '.*($|{)"'
endfunction

noremap <f12> :call PhpImplementations('<cword>')<CR>
" Automatically open & close quickfix window
autocmd QuickFixCmdPost [^l]* nested cwindow

"/
"/ Javascript libraries
"/
" autocmd FileType vue syntax sync fromstart
autocmd FileType vue set iskeyword-=.

"/
"/ CtrlP
"/
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|vendor\|storage\|public/storage'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
nmap <c-r> :CtrlPBufTag<cr>
nmap <c-e> :CtrlPMRUFiles<cr>

"/
"/ NERDTree
"/
let NERDTreeHijackNetrw = 0
nmap <c-b> :NERDTreeToggle<cr>

"/
"/ Emmet
"/
let g:user_emmet_mode='n'    "only enable normal mode functions.
let g:user_emmet_mode='inv'  "enable all functions, which is equal to
let g:user_emmet_mode='a'    "enable all function in all mode.
let g:user_emmet_install_global = 0
autocmd FileType html,css,vue,blade,htm,php EmmetInstall
imap <Leader><Leader> <esc><c-y>,


"/
"/ Vim php namespace
"/
function! IPhpInsertUse()
    call PhpInsertUse()
    call feedkeys('a',  'n')
endfunction
autocmd FileType php inoremap <Leader>n <Esc>:call IPhpInsertUse()<CR>
autocmd FileType php noremap <Leader>n :call PhpInsertUse()<CR>

function! IPhpExpandClass()
    call PhpExpandClass()
    call feedkeys('a', 'n')
endfunction
autocmd FileType php inoremap <Leader>nf <Esc>:call IPhpExpandClass()<CR>
autocmd FileType php noremap <Leader>nf :call PhpExpandClass()<CR>

"/
"/ pdv
"/
let g:pdv_template_dir = $HOME ."/.vim/bundle/pdv/templates_snip"
nnoremap <Leader>d :call pdv#DocumentWithSnip()<CR>

"/
"/ Ultisnips
"/
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


"/
"/ Vim multiple cursor
" <c-n> default
"/

"/
"/ Auto complete with c space
"/
imap <c-Space> <c-n>


"/
"/ Bookmarks 
"/
" let g:bookmark_save_per_working_dir = 1
let g:bookmark_auto_save = 1

"*****************************************************************************************"
" >>> Key Mapping
"*****************************************************************************************"

" Press F7 to activate spell checking, F8 to turn it off.
map <F7> <Esc>:setlocal spell spelllang=en_us<CR>
map <F8> <Esc>:setlocal nospell<CR>

"new tab
nmap <c-t> :tabnew %<cr>
"Go to brackets
nmap <Leader>{ <esc>va{<esc>%
nmap <Leader>} <esc>va{<esc>

"duplicate selected
vmap <c-d> ygv<s-v><esc>p
"Tag visual selection
vmap <Leader>t yi<<esc>pli></<esc><s-A>><esc><s-i><esc>f>

"Make it easy to edit the vimrc file
nmap <Leader>ev :tabedit ~/.vimrc<cr>
nmap <Leader>ep :tabedit ~/.vim/plugins.vim<cr>
nmap <cr> :nohlsearch<cr>

"bring back ctrl-s
nmap <c-s> :w<cr>
imap <c-s> <ESC>:w<cr>i
vmap <c-s> <ESC>:w<cr>v

"Bring back ctrl-c and ctrl-v
nmap <c-d> yyp<cr><S-i><esc>l
imap <c-d> <ESC>yyp<cr>i
vmap <C-c> "+y
vmap <C-x> "+c
imap <C-v> <ESC>"+p

"Bring back ctrl-z
nmap <c-z> u
imap <c-z> <ESC>ui
vmap <c-z> <ESC>uv

"Select all file
nmap <c-a> ggVG
vmap <c-a> <ESC>ggVG

"Insert ; end of the line
nmap <Leader>z <ESC><S-a>;<ESC>

"Select all document
nmap <Leader>a gg<S-v><S-g>

"ctrl f
imap <c-f> <ESC>/
nmap <c-f> /
vmap <c-f> <ESC>/

"Indent line
vmap <tab> >gv
vmap <S-tab> <gv
nmap <tab> V><ESC>
nmap <S-tab> V<<ESC>

"close window
nmap <c-w> :q!<cr>

"*****************************************************************************************"
" >>> Performance
"*****************************************************************************************"

set foldmethod=manual

"*****************************************************************************************"
" >>> Auto-commands
"*****************************************************************************************"

"Automatically source the Vimrc file on save
augroup autosourcing
  autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

"*****************************************************************************************"
"*****************************************************************************************"
"*********************************** >>> END <<< *****************************************"
"*****************************************************************************************"
"*****************************************************************************************"
