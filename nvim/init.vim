syntax on

if &compatible
  set nocompatible
endif

if has('vim_starting')
  set runtimepath+=/Users/jburwell/.config/nvim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('/Users/jburwell/.config/nvim/bundle'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-airline/vim-airline'
NeoBundle 'vim-airline/vim-airline-themes'
NeoBundle 'shougo/deoplete.nvim'
NeoBundle "preservim/nerdtree"
NeoBundle 'hashivim/vim-terraform'
NeoBundle 'vim-syntastic/syntastic'
NeoBundle 'juliosueiras/vim-terraform-completion'
NeoBundle 'universal-ctags/ctags'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'pprovost/vim-ps1'
NeoBundle 'bash-support.vim'
NeoBundle 'aliou/bats.vim'

call neobundle#end()

filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

set clipboard+=unnamedplus
set ruler
set number
set tabstop=2
set shiftwidth=2
set expandtab
set backspace=indent,eol,start
set ff=unix
set autoread

set nobackup
set nowritebackup

set rtp+=/opt/homebrew/opt/fzf

autocmd FileType gitcommit setlocal spell textwidth=72
autocmd FileType gitcommit exec 'au VimEnter * startinsert'

" Airline theme configuration
let g:airline_theme = 'solarized'
let g:airline_solarized_bg = 'dark'

" Syntastic configuration
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 1
