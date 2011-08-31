# .zshrc
# Author - Krzysztof Czajkowski <krzysztof@czajkowski.edu.pl>
# version 0.2 - 31.08.2011
# Special thanks to cla <cla@gentoo.org>, which motivated me to 
# create a config and from which lent a bit of code.
# Special thanks to liDEL (http://lidel.org).
# Updates: http://github.com/czaja/dotfiles/
# License: public domain

export ECHANGELOG_USER="Krzysztof Czajkowski <krzysztof@czajkowski.edu.pl>"

# history
export HISTSIZE=10000
HISTFILE=${HOME}/.history
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
setopt hist_expire_dups_first
setopt hist_ignore_space
setopt hist_no_store
setopt inc_append_history
setopt extended_history
setopt hist_reduce_blanks
#HISTTIMEFORMAT='%a, %d %b %Y %l:%M:%S%p %z '

# autoload
autoload -U promptinit colors compinit zmv # zmv -> smart mv: zmv '(*).lis' '$1.txt'
compinit
colors

# local -- define private stuff there
if [ -r ${HOME}/.zshrc_local ]; then
	. ${HOME}/.zshrc_local
fi

if [ -r ${HOME}/.zshrc_prompt ]; then
   . ${HOME}/.zshrc_prompt
elif [ -r /home/czaja/.zshrc_prompt ] ; then
   . /home/czaja/.zshrc_prompt
fi

# style

# completion cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache

# ignore completion functions for commands you don't have
zstyle ':completion:*:functions' ignored-patterns '_*'

#zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes
#zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*:options' description 'yes'
#zstyle ':completion:*:options' auto-description '%d'
#zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
#zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

zstyle ':completion:*' remove-all-dups true
zstyle ':completion:*' use-cache true
zstyle ':completion:*' completer _complete _prefix
zstyle ':completion:*' add-space true
#zstyle ':completion:*' completer _complete _prefix _approximate
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:corrections' format '%B%d (bledy: %e)%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format '%BNic nie znaleziono dla: %d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# PID completion: kill X<TAB>
zstyle ':completion:*:processes' command 'ps xw -o pid,tty,time,args'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) #([^ ]#) #([^ ]#)*=1;32=1;31=1;35=1;33'
#zstyle ':completion:*:kill:*' force-list always

zstyle ':completion:*' menu select=long-list select=1
zstyle ':completion:*' list-prompt '%Bnie weszlo na ekran, przewijanie aktywne%b'
zstyle ':completion:*' select-prompt '%BPrzewinieto %p%b'
zstyle ':completion:*:*:*:*' list-suffixes yes
zstyle ':completion:*' ignore-parents parent pwd
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zstyle ':completion:*' separate-sections true
zle -C all-matches complete-word _generic
bindkey '^Xx' all-matches # C-x-x
zstyle ':completion:all-matches::::' completer _all_matches _complete _match
zstyle ':completion:all-matches:*' insert true
zstyle ':completion:all-matches:*' old-matches true

# Fix keyboard
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

for k in ${(k)key} ; do
        # $terminfo[] entries are weird in ncurses application mode...
	[[ ${key[$k]} == $'\eO'* ]] && key[$k]=${key[$k]/O/[}
done
unset k

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

bindkey "^R" history-incremental-search-backward

# few things
setopt AUTO_CD
setopt CORRECT
setopt MENU_COMPLETE
setopt CHECK_JOBS
setopt PRINT_EXIT_VALUE
setopt NOTIFY
setopt CORRECT_ALL
setopt SHORT_LOOPS
setopt NO_HUP
setopt extended_glob
setopt interactive_comments
setopt auto_remove_slash
setopt complete_in_word
setopt auto_remove_slash

umask 022

watch=all
logcheck=30
WATCHFMT="User %n has %a on tty %l at %T %W"

# Display path in titlebar of terms.
[[ -t 1 ]] || return
   case $TERM in
      *xterm*|*rxvt*|(dt|k|E)term)
      precmd() {
         print -Pn "\e]2;[%n] : [%m] : [%~]\a"
      }
      preexec() {
         print -Pn "\e]2;[%n] : [%m] : [%~] : [ $1 ]\a"
      }
      ;; 
   esac 

# Linux or BSD ls
if [[ $OSTYPE = linux* ]]; then
    alias ls="ls --color=auto --classify $* --group-directories-first"
    alias ll="ls -lh --color=auto --classify $* --group-directories-first"
    alias la="ls -lha --color=auto --classify $* --group-directories-first"
    alias grep='grep --color=auto'
elif [[ $OSTYPE = freebsd* ]]; then 
    export CLICOLOR="YES"
    export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"
    alias ls="ls -GF"
    alias ll="ls -lhGF"
    alias la="ls -lhaGF"
fi

# colors
if [ -x /usr/bin/dircolors ]; then
   if [[ -f ~/.dir_colors ]]; then
      eval `dircolors -b ~/.dir_colors`
   elif [[ -f /etc/DIR_COLORS ]]; then
      eval `dircolors -b /etc/DIR_COLORS`
   else 
      eval `dircolors`
   fi
fi

# exporting colors
export GREP_COLOR=31

# even more colour-candy with app-misc/grc (http://goo.gl/2z2j)
if [ "$TERM" != dumb ] && [ -x /usr/bin/grc ] ; then
   alias cl='/usr/bin/grc -es --colour=auto'
   alias configure='cl ./configure'
   alias diff='cl diff'
   alias gcc='cl gcc'
   alias g++='cl g++'
   alias as='cl as'
   alias gas='cl gas'
   alias ld='cl ld'
   alias netstat='cl netstat'
   alias ping='cl ping'
fi

# MC chdir enhancement under Gentoo
if [ -f /usr/share/mc/mc.gentoo ]; then
   . /usr/share/mc/mc.gentoo
fi

# aliases
alias psaux="ps aux"
alias rr="rm -Rf"
alias dv="dirs -v"
alias recent="ls -rl *(D.om[1,10])"
alias grep="grep --color=auto "
alias wcat="wget -q -O -"
alias whatismyip="wget -O- -q whatismyip.org"
alias tlzma="tar -c $* | lzma -c9 > $1.tar.lzma" # deprecated?
alias du_dir="find . -maxdepth 1 -type d | xargs du -sb | sort -n"
alias png2jpg="mogrify -format jpg -quality 90 *.png"
alias e="emerge"
alias d='dirs -v'
alias c="cd ~ ; clear"
alias mv="nocorrect mv -v"
alias rm="nocorrect rm -v"
alias cp="nocorrect cp -v"

# global aliases
alias -g '...'='../..'
alias -g '....'='../../..'
alias -g l="ls"
alias -g M="| more"
alias -g H="| head"
alias -g T="| tail"
alias -g G="| grep"
alias -g L="| less"
alias -g sshl2="luit -x -encoding 'ISO 8859-2' ssh"

# editor
export EDITOR="/usr/bin/vim"

# weird commands for my use.

status() {
        echo "Date  : $(date "+%Y-%m-%d %H:%M:%S")"
        echo "Shell : Zsh $ZSH_VERSION (PID = $$, $SHLVL nests)"
        echo "Term  : $TTY ($TERM), $BAUD bauds, $COLUMNS x $LINES cars"
        echo "Login : $LOGNAME (UID = $EUID) on $HOST"
        echo "System: $(cat /etc/[A-Za-z]*[_-][rv]e[lr]*)"
        echo "Kernel: $(uname -r)"
	echo "Uptime:$(uptime)"
}

# incognito mode
incognito() {
   export HISTFILE=/dev/null
   PROMPT='incognito> '
}

# youtube with mplayer
yt() {
	cookiefile="/tmp/cookies-$( date +%s.%N ).txt";
	url=$( youtube-dl --cookies $cookiefile -g "$@" );
	mplayer2 -cookies -cookies-file $cookiefile $url;
	rm -f $cookiefile
}

# create a shot of screen an place it in proper directory
shot() {
        [[ ! -d ~/shots ]] && mkdir ~/shots
        cd ~/shots
        [[ -z "$1" ]] && echo "Failed with no argument!" && return
        scrot -cd 5 $(date +%Y_%m_%d_%H-%M)-$1.png
}

# Create an index with thumbs. You will need media-gfx/imagemagick to make this
# script working.
genthumbs () {
        rm -rf thumb-* index.html
        echo "
<html>
  <head>
        <title>Images</title>
  </head>
  <body>" > index.html
        for f in *.(gif|jpeg|jpg|png)
        do
            convert -size 100x200 "$f" -resize 100x200 thumb-"$f"
            echo "    <a href=\"$f\"><img src=\"thumb-$f\"></a>" >> index.html
        done
        echo "
  </body>
</html>" >> index.html
}

# vim as a man-page reader
# # put in your ~/.vimrc :
# # autocmd FileType man setlocal ro nonumber nolist fdm=indent fdn=2 sw=4 foldlevel=2 | nmap q :quit<CR>
vman() {
   if [ $# -eq 0 ]; then
      /usr/bin/man
   else
      if man -w $* >/dev/null 2>/dev/null
      then
         /usr/bin/man $* | col -b | vim -c 'set ft=man nomod' -
      else
         echo No man page for $*
      fi
   fi
}

# simple notifier
saydone () {
   if [ $? = 0 ]; then
      notify-send -i gtk-dialog-info "done :-)"
   else
      notify-send -i gtk-dialog-info --urgency=critical "failed :-("
   fi
}

# files with space in the name are evil!
space_rm() {
        for file in *; do
                mv ${file} ${file:gs/\ /_/}
        done
}

# files with [:upper:] characters in the name are evil as well!
lowercase_mv() {
        for file in *; do
                mv ${file} ${file//(#m)[A-Z]/${(L)MATCH}}
        done
}

# list only file that are images
limg() {
        local -a images
        images=( *.{jpg,jpeg,gif,png,JPG,JPEG,GIF,PNG}(.N) )
        if [[ $#images -eq 0 ]] ; then
                print "No image files found."
        else
                ls "$@" "$images[@]"
        fi
}

google() {
        local str opt
            if [ $# != 0 ]; then
                for i in $*; do
	            str="$str+$i"
                done
    	    str=`echo $str | sed 's/^\+//'`
    	    opt='search?rls=pl&ie=utf-8&oe=utf-8'
    	    opt="${opt}&q=${str}"
    	    fi
echo "http://www.google.pl/${opt}"
}

pwn() {
        local str opt                     
            if [ $# != 0 ]; then          
                for i in $*; do           
        	    str="$str+$i"         
                done                      
            str=`echo $str | sed 's/^\+//'`
            opt='lista.php'               
            opt="${opt}?co=${str}"
	    fi
echo "http://so.pwn.pl/${opt}"
}

# list only file that are videos
lvid() {
        local -a videos
        videos=( *.{mpg,mpeg,mp4,wmv,rm,rmvb,avi,flv,mkv,3gp,MPG,MPEG,MP4,WMV,RM,RMVB,AVI,FLV,MKV,3GP}(.N) )
        if [[ $#videos -eq 0 ]] ; then
                print "No video files found."
        else
                ls "$@" "$videos[@]"
        fi
}

# show me TODO.
[ -e ~/TODO ] && < ~/TODO

# DIE SATANA!
die() {
    echo $1
    return 0
}

# to update .zshrc from terminal
updaterc-zsh() {
   ping -q -c1 github.com && \
   cp ~/.zshrc ~/.zshrc.old && \
   wget http://github.com/czaja/dotfiles/raw/master/.zshrc -O ~/.zshrc && \
   wget http://github.com/czaja/dotfiles/raw/master/.zshrc_prompt -O ~/.zshrc_prompt
}

updaterc-vim() {
   ping -q -c1 github.com && \
   cp ~/.zshrc ~/.zshrc.old && \
   wget http://github.com/czaja/dotfiles/raw/master/.vimrc -O ~/.vimrc
}

# distcc options for automake
#export DISTCC_DIR="/var/tmp/portage/.distcc/"
#export PATH="/usr/lib/distcc/bin:${PATH}"
