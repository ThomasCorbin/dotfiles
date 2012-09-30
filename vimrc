" Map leader to ,
"
" The leader character is your own personal modifier key,
" as g is Vim's modifier key (when compared to vi).
" The default leader is \, but this isn't located standardly
" on all keyboards and requires a pinky stretch in any case.
"
let mapleader = ","



"       Tim Pope's pathogen - loads all the bundles
call pathogen#infect()



" make current file's dir vim's current dir
" file rooter.vim   vim-root, find .git dir to find root
set autochdir

" Insert spaces instead of tabs.
set expandtab

" highlight matches when searching
set hlsearch

" turn on incremental searching
set incsearch

set list
set listchars=tab:▸\ ,trail:·,eol:¬
set nu!
set shiftwidth=2
" set syntax
set tabstop=2




map <F5> :NERDTreeToggle<CR><CR>



" Easily switch windows by pressing <Ctrl> + the direction of the window you want.
"
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l



"   Much of the following settings come from here.
"   http://items.sjbach.com/319/configuring-vim-right


" Remap ` to '
"
" These are very similar keys. Typing 'a will jump to the line in the
" current file marked with ma. However, `a will jump to the line and column marked with ma.
"
" It's more useful in any case I can imagine, but it's located way
" off in the corner of the keyboard.  The best way to handle this
" is just to swap them.
"
" Apostrophe is a line movement command, and Backtick is a text movement command.
" Since vim is both line editor and a text editor, it makes a big difference which
" you use. Personally, I use line commands way more often than text commands, as they
" are quicker to fire off. "ma j j j d'a" will cut 4 lines of text, no matter what
" column your cursor is in. Likewise, you can paste these w/o regard for the cursor
" column and vim does the right thing (@" is marked as a line register from the cut).
" I guess this thing would depend on your usage pattern of course.
" nnoremap ' `
" nnoremap ` '


" Keep a longer history
"
" By default, Vim only remembers the last 20 commands
" and search patterns entered. It's nice to boost this up:
"
set history=1000


" Enable extended % matching
"
" The % key will switch between opening and closing brackets.
" By sourcing matchit.vim - a standard file in Vim installations
" for years - the key can also switch among e.g. if/elsif/else/end,
" between opening and closing XML tags, and more.
"
" Note: runtime is the same as source except that the path is
" relative to the Vim installation directory.
"
runtime macros/matchit.vim


" Make file/command completion useful
"
" By default, pressing <TAB> in command mode will choose the
" first possible completion with no indication of how many others
" there might be. The following configuration lets you see what
" your other options are:
"
set wildmenu

" To have the completion behave similarly to a shell, i.e. complete
" only up to the point of ambiguity (while still showing you what
" your options are), also add the following:
"
set wildmode=list:longest,full


" Set the terminal title
"
" A running gvim will always have a window title,
" but when vim runs within an xterm, by default
" it inherits the terminal's current title.
"
"        This gives e.g. | page.html (~) - VIM |.
"
set title


" Use case-smart searching
"
" These two options, when set together, will
" make /-style searches case-sensitive only
" if there is a capital letter in the search expression.
" *-style searches continue to be consistently case-sensitive.
"
" This is usually the most useful combination.
"
set ignorecase
set smartcase




"  The fancy powerline/status line
let g:Powerline_symbols = 'fancy'
set laststatus=2


autocmd BufWritePre *.pl :%s/\s\+$//e
autocmd BufWritePre *.java :%s/\s\+$//e
autocmd BufWritePre *.rb :%s/\s\+$//e



highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/



"
" appearance options
"
set bg=dark
let g:zenburn_high_Contrast = 1
let g:liquidcarbon_high_contrast = 1
" let g:molokai_original = 0
set t_Co=256

" colorscheme molokai
colorscheme vibrantink

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
set gfn=Liberation\ Mono\ 14




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

" Disable all blinking
:set guicursor+=a:blinkon0




" Save your backups to a less annoying place than the current directory.
" If you have .vim-backup in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/backup or . if all else fails.
if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

" viminfo stores the the state of your previous editing session
set viminfo+=n~/.vim/viminfo

if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif

