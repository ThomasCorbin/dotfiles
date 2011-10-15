set nu!
set tabstop=4
set shiftwidth=4 
set expandtab
set hlsearch
set tabstop=4
set list

set listchars=tab:▸\ ,eol:¬


"
" appearance options
"
set bg=dark
let g:zenburn_high_Contrast = 1
let g:liquidcarbon_high_contrast = 1
" let g:molokai_original = 0
set t_Co=256

colorscheme molokai

if has("gui_running")
" set default size: 90x35
    set columns=129
    set lines=40
    let g:obviousModeInsertHi = "guibg=Black guifg=White"
else
    let g:obviousModeInsertHi = "ctermfg=253 ctermbg=16"
endif

if has("win32") || has("win64")
    set gfn=Consolas:h12:cANSI
endif




nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

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

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " autocmd BufReadPost *
  "   \ if line("'\"") > 0 && line("'\"") <= line("$") |
  "   \   exe "normal g`\"" |
  "   \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" For Haml
" au! BufRead,BufNewFile *.haml         setfiletype haml

