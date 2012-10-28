"  .vimrc {
"  by Krzysztof Czajkowski (http://czajkowski.edu.pl)
"
"  Some things copied from Marcin Rataj`s config (http://lidel.org).
"
"  License: public domain
"  Updates: https://github.com/czaja/dotfiles/
"
"  Recommended:
"     http://www.vim.org/scripts/script.php?script_id=2540
"     http://www.vim.org/scripts/script.php?script_id=1658
"     http://www.vim.org/scripts/script.php?script_id=521
" }

" Eyelook {
	set t_Co=256	                 " force 256 term (x11-terms/rxvt-unicode +xterm-color under Gentoo)
	syntax on
	"set number
	"colorscheme twilight	        " http://www.vim.org/scripts/script.php?script_id=1677
	"colorscheme xoria256	        " http://svn.ungrund.org/system/skel/.vim/colors/xoria256.vim
   colorscheme desert              " http://fugal.net/vim/colors/desert.vim
   "set background=dark
" }   

" Default encoding {
	set fileencodings=utf-8,latin2
	set termencoding=utf-8
	set encoding=utf-8
	scriptencoding utf-8
" }

" General file handling {
	filetype plugin on              " recognize filetypes
	filetype indent on
	set nowrap                      " Word wrap is the devil.

	set autochdir                   " always switch to the current file directory
	set fileformats=unix,dos,mac    " support all three, in this order
	set backup                      " make backup files
	set backupcopy=yes              " don't break symlinks
	set backupdir=~/.vim/backup     " where to put backup files
	set directory=~/.vim/tmp        " directory to place swap files in
                                   " I don't want to edit these files
	set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.swp,*.jpg,*.gif,*.png
" }

" UI tweaks {
	set nocompatible                " don't be compatible with vi
	set spelllang=pl                " default to polish
	set ttyfast                     " assume fast terminal connection
	set scrolloff=5                 " keep 3 lines below and above the cursor
	set sidescrolloff=10            " keep 5 lines at the size
	set ruler                       " row / column of cursor
	set modeline                    " last lines in document sets vim mode
	set modelines=3                 " number lines checked for modelines
	set shortmess=aTI               " no 'welcome' message
	set confirm                     " to get a dialog when a command fails
	set shell=zsh
	set listchars=tab:>-,trail:.,eol:$  " chars to show for :set list -> <F5>
	set guitablabel=%N/\ %t\ %M     " tab labels show the filename without path
	"set cursorline                  " highlight the current column
	"set cursorcolumn                " highlight the current column
	set lazyredraw                  " do not redraw while running macros
	set nostartofline               " leave my cursor where it was
	set ignorecase                  " case insensitive by default
	set infercase                   " case inferred by default
	set smartcase                   " if there are caps, go case-sensitive
	set shiftround                  " when at 3 spaces, and I hit > ... go to 4, not 5
	"set mouse+=a                    " use mouse everywhere, dont copy line numbers :)
                                   " Highlight redundant whitespaces
	highlight RedundantSpaces ctermbg=blue guibg=blue
	match RedundantSpaces /\s\+$\| \+\ze\t/
	set showmatch                   " show matching brackets
	set matchtime=5                 " how many tenths of a second to blink
                                   " matching brackets for

" }                              

" Default identation settings
	set expandtab                   " use spaces as tabs
	set softtabstop=3               " use 4 softtabstops
	set shiftwidth=3                " spaces to use for autoindent
	set tabstop=3                   " real tabs
	set autoindent                  " always set autoindenting on
	set smartindent                 " smartindent! :)
	"set nosmarttab                 " always use tabstops
" }

" Keybindings {
   set backspace=indent,eol,start      " make backspace a more flexible
   nnoremap    <F2> :set list!<CR>     " F2: Toggle list (display unprintable characters).
   nmap        <F5> :set nu!<CR>       " toggle line numbers
   set         pastetoggle=<F11>       " pastetoggle - this toggles 'paste'
   nmap        <F7> :set spell!<CR>    " toggle spellcheck

   fun RmCR()
       set fileformats=unix            " to see those ^M while editing a dos file.
       let oldLine=line('.')
       exe ":%s/\r//g"
       exe ':' . oldLine
    endfun
   "map         <F6> :call RmCR()<CR>  " ^M removal
" }

" Small macros and fixes {
   " NOCAPS :W = :w :Q = :q
   nmap :W :w
   nmap :Q :q
   " We all hate hitting q: instead of :q ;-)
   nnoremap q: q:iq<esc>
   " Suppress all spaces at end/beginning of lines
   nmap _s :%s/\s\+$//<CR>
	nmap _S :%s/^\s\+//<CR>
" }

" MAN wrapper {
   autocmd FileType man setlocal ro nonumber nolist fdm=indent fdn=2 sw=4 foldlevel=2 | nmap q :quit<CR>
" }

" MRU {
   " http://www.vim.org/scripts/script.php?script_id=521
   let MRU_File = '/home/czaja/.vim_mru_files'
   let MRU_Max_Entries = 1000
   "let MRU_Exlude_Files = '^/tmp/.*\|^/var/tmp/.*'
   let MRU_Windows_Height = 15
   let MRU_Use_Current_Window = 1
   let MRU_Auto_Close = 0
   let MRU_Add_Menu = 0
   let MRU_Max_Menu_Entries = 20
   let MRU_Max_Submenu_Entries = 15
" }
