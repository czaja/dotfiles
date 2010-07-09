# .zshrc
# Author - Krzysztof Czajkowski <czaja@arker.pl>
# 16.02.2010
# Special thanks to cla <cla@gentoo.org>, which motivated me to 
# create a config and from which lent a bit of code.
# Updates: http://github.com/lidel/dotfiles/
# License: public domain

export ECHANGELOG_USER="Krzysztof Czajkowski <czaja@arker.pl>"

# manuals in vim
#export MANPAGER="col -b | vim -R -c 'set fileencoding=iso-8859-2 termencoding=utf-8 ft=man nomod nolist' -"

# history
export HISTSIZE=10000
HISTFILE=${HOME}/.history
export SAVEHIST=$HISTSIZE
#export HISTFILESIZE=999999
#HISTTIMEFORMAT='%a, %d %b %Y %l:%M:%S%p %z '

# prompt colors
local RED=$'%{\e[0;31m%}'
local GREEN=$'%{\e[0;32m%}'
local YELLOW='%{\e[0;33m%}'
local BLUE=$'%{\e[0;34m%}'
local PINK=$'%{\e[0;35m%}'
local CYAN=$'%{\e[0;36m%}'
local GREY=$'%{\e[1;30m%}'
local NORMAL=$'%{\e[0m%}'

# autoload
autoload -U promptinit colors compinit
compinit
colors

# local -- define private stuff there
if [ -r ${HOME}/.zshrc_local ]; then
	. ${HOME}/.zshrc_local
fi

# exporting prompt
if [[ ${UID} == "0" ]]; then
        if [[ ${HOST} == "erode" ]]; then
    		#promptinit
    		#prompt gentoo
		RPROMPT="${BLUE}[${RED}%T${BLUE}]${NORMAL}"
		export PS1="$(print "${BLUE}[${RED}%~${BLUE}]${RED} %(!.#.$) ${NORMAL}")"
    		#export PS1="$(print "${NORMAL}[${GREEN}%M${NORMAL}][${YELLOW}%~${NORMAL}]${RED} %(!.#.$) ${NORMAL}")"
	else
		#promptinit
		#prompt gentoo
		RPROMPT="${BLUE}[${RED}%T${BLUE}]${NORMAL}"
		#export PS1="$(print "${GREY}[${YELLOW}%M${GREY}][${YELLOW}%~${GREY}]${YELLOW} %(!.#.$) ${NORMAL}")"
		export PS1="$(print "${BLUE}[${RED}%M${BLUE}][${RED}%~${BLUE}]${RED} %(!.#.$) ${NORMAL}")"
	fi
else
        if [[ ${HOST} == "erode" ]]; then
                RPROMPT="${BLUE}[${GREEN}%T${BLUE}]${NORMAL}"
                #export PS1="$(print "${GREY}[${YELLOW}%~${GREY}]${YELLOW} %(!.#.$) ${NORMAL}")"
                export PS1="$(print "${BLUE}[${GREEN}%~${BLUE}]${GREEN} %(!.#.$) ${NORMAL}")"
                #export PS1="$(print "${YELLOW}[${RED}%~${YELLOW}]${RED} %(!.#.$) ${NORMAL}")"
                #export PS1="$(print "${NORMAL}[${RED}%M${NORMAL}][${YELLOW}%~${NORMAL}]${GREEN} %(!.#.$) ${NORMAL}")"
                #export PS1="$(print "[${YELLOW}%~${NORMAL}]${GREEN} %(!.#.$) ${NORMAL}")"
        else
                #promptinit
		#prompt gentoo
		RPROMPT="${BLUE}[${GREEN}%T${BLUE}]${NORMAL}"
		#export PS1="$(print "${GREY}[${YELLOW}%M${GREY}][${YELLOW}%~${GREY}]${YELLOW} %(!.#.$) ${NORMAL}")"
		export PS1="$(print "${BLUE}[${GREEN}%M${BLUE}][${GREEN}%~${BLUE}]${GREEN} %(!.#.$) ${NORMAL}")"
        fi
fi

# style
#zstyle ':completion:*' use-cache on
#zstyle ':completion:*' cache-path ~/.zsh/cache
#zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes
#zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*:options' description 'yes'
#zstyle ':completion:*:options' auto-description '%d'
#zstyle ':completion:*:(all-|)files' ignored-patterns '(|*/)CVS'
#zstyle ':completion:*:cd:*' ignored-patterns '(*/)#CVS'

zstyle ':completion:*' remove-all-dups true
zstyle ':completion:*' use-cache true
setopt complete_in_word
zstyle ':completion:*' completer _complete _prefix
zstyle ':completion:*' add-space true
#zstyle ':completion:*' completer _complete _prefix _approximate
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:corrections' format '%B%d (bledy: %e)%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format '%BNic nie znaleziono dla: %d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
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
bindkey '^Xx' all-matches
zstyle ':completion:all-matches::::' completer _all_matches _complete _match
zstyle ':completion:all-matches:*' insert true
zstyle ':completion:all-matches:*' old-matches true

# Repair HOME/END keys and others.

#autoload zkbd
#function zkbd_file() {
#    [[ -f ~/.zkbd/${TERM}-${VENDOR}-${OSTYPE} ]] && printf '%s'
#    ~/".zkbd/${TERM}-${VENDOR}-${OSTYPE}" && return 0
#    [[ -f ~/.zkbd/${TERM}-${DISPLAY}          ]] && printf '%s'
#    ~/".zkbd/${TERM}-${DISPLAY}"          && return 0
#    return 1
#}
#
#[[ ! -d ~/.zkbd ]] && mkdir ~/.zkbd
#keyfile=$(zkbd_file)
#ret=$?
#if [[ ${ret} -ne 0 ]]; then
#	zkbd
#	keyfile=$(zkbd_file)
#	ret=$?
#fi
#if [[ ${ret} -eq 0 ]] ; then
#	source "${keyfile}"
#else
#	printf 'Failed to setup keys using zkbd.\n'
#fi
#unfunction zkbd_file; unset keyfile ret

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo

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

#unsetopt MULTIBYTE

# few things
setopt AUTO_CD
setopt CORRECT
setopt MENU_COMPLETE
setopt CHECK_JOBS
setopt PRINT_EXIT_VALUE
setopt HIST_IGNORE_SPACE
setopt HIST_IGNORE_ALL_DUPS
setopt NOTIFY
setopt CORRECT_ALL
setopt SHORT_LOOPS
setopt NO_HUP
setopt extended_history
setopt extended_glob
setopt interactive_comments
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

# aliases
if [[ $(uname) == "Linux" ]]; then
    alias ls="ls --color=auto --classify $* --group-directories-first"
    alias ll="ls -lh --color=auto --classify $* --group-directories-first"
    alias la="ls -lha --color=auto --classify $* --group-directories-first"
    alias grep='grep --color=auto'
else
# freebsd
    CLICOLOR="YES";    export CLICOLOR                                                                                                                            
    LSCOLORS="ExGxFxdxCxDxDxhbadExEx";    export LSCOLORS
    alias ls="ls -GF"
    alias ll="ls -lhGF"
    alias la="ls -lhaGF"
fi

# ls colors
#if [ "$TERM" != "dumb" ]; then
#    #eval "`dircolors -b`"
#    alias ls="ls --color=auto --classify $*"
#    alias grep='grep --color=auto'
#    #alias dir='ls --color=auto --format=vertical'
#    #alias vdir='ls --color=auto --format=long'
#fi

# colors
if [[ -f ~/.dir_colors ]]; then
            eval `dircolors -b ~/.dir_colors`
else
        if [[ -f /etc/DIR_COLORS ]]; then
            eval `dircolors -b /etc/DIR_COLORS`
#else 
#	eval "`dircolors -b`"
	fi
fi

# exporting colors
export GREP_COLOR=31

# global aliases
alias -g '...'='../..'
alias -g '....'='../../..'
alias -g l="ls"
alias -g M="| more"
alias -g H="| head"
alias -g T="| tail"
alias -g G="| grep"
alias -g L="| less"
alias mv="mv -v"
alias rm="rm -v"
alias cp="cp -v"
alias -g sshl2="luit -x -encoding 'ISO 8859-2' ssh"

# editor
#export EDITOR="/usr/bin/mcedit"
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

updaterc() {
        wget http://somehttp/.zshrc -O ${1}/.zshrc
}

# distcc options for automake
#export DISTCC_DIR="/var/tmp/portage/.distcc/"
#export PATH="/usr/lib/distcc/bin:${PATH}"
