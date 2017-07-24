# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
#[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    ;;
*)
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]:$(__git_ps1 "(%s)")\$ '
    ;;
esac

# Comment in the above and uncomment this below for a color prompt
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac


#####  Testing command line shit 

parse_git_branch () {
        git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)#(git::\1)#'
}
parse_svn_branch() {
        parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "(svn::"$1 "/" $2 ")"}'
}
parse_svn_url() {
        svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root() {
        svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}

#PS1="\[\033[00m\]\u@\h\[\033[01;34m\] \w \[\033[31m\]\$(parse_git_branch)\$(parse_svn_branch) \[\033[00m\]$\[\033[00m\] "
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]:\[\033[31m\]$(parse_git_branch)$(parse_svn_branch) \[\033[00m\]$\[\033[00m\]  '

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi


# Useful shell options
shopt -s lithist     # store multi-line cmds in history as multi lines
shopt -s nocaseglob  # perform case-insensitive globbing
shopt -s cdspell     # do spell check when cd'ing somewhere
shopt -s no_empty_cmd_completion # avoid searching for cmds when none typed 

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

alias ack='ack-grep'

export EDITOR=vim
set -o vi


# Weather by us zip code - Can be called two ways # weather 50315 # weather "Des Moines"
weather () {
    declare -a WEATHERARRAY
    WEATHERARRAY=( `lynx -dump "http://www.google.com/search?hl=en&lr=&client=firefox-a&rls=org.mozilla%3Aen-US%3Aofficial&q=weather+${1}&btnG=Search" | grep -A 5 -m 1 "Weather for"`)
    echo ${WEATHERARRAY[@]}
}

#because ubuntu is horked
#alias svn='LD_PRELOAD=/usr/lib/libneon.so.27 svn'
#alias git='LD_PRELOAD=/usr/lib/libneon.so.27 git'
if [ -f /home/waboring/.hostloadcolour ]; then
    source /home/waboring/.hostloadcolour
    hostloadcolour
fi

# transfer.sh support
# useage
# transfer <filename>
if [ -f ~/.transfer.sh ]; then
    source ~/.transfer.sh
fi


# System dependent options here
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    # ...
    # Useful shell options
    shopt -s globstar    # permit patterns like **/*.jar to match any jar below
    shopt -s dirspell    # do spell check when typing a dir

    alias ls-al='ls -lhFA'
    # enable color support of ls and also add handy aliases
    if [ "$TERM" != "dumb" ]; then
        eval "`dircolors -b`"
        alias ls='ls --color=auto'
        #alias dir='ls --color=auto --format=vertical'
        #alias vdir='ls --color=auto --format=long'
    fi

elif [[ "$OSTYPE" == "darwin"* ]]; then
    # Mac OSX
    export CLICOLOR=1
    export LSCOLORS=ExFxBxDxCxegedabagacad
    alias ls='ls -GFh'
fi

alias ll='ls -lhFA'
#alias mvn='mvn -P \!create-iso,\!create-installation,\!local-server'
alias mvn='mvn -P \!create-iso,\!create-installation'
alias bashrc="vim ~/.bashrc && source ~/.bashrc"
alias vssh="vagrant ssh"

alias cd..="cd .."
alias ..="cd .."
alias ...="cd ../.."

alias moer="more"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias install="sudo apt-get install"
alias archey="pyarchey"
alias xdg="xdg-open"
alias google="chromium-browser http://www.gogle.com"
alias homedev="ssh -X hemna.mynetgear.com"
alias dev="ssh -X 192.168.1.44"
alias wx="wego -l '38.837333,-121.0187007'"

#SUSE
alias hlm201="ssh stack@10.84.88.1"
alias hlm202="ssh stack@10.84.89.1"

# run git pull origin master in every subdirectory from .
alias gp="find . -name .git -type d -execdir git pull origin master -v ';'"

cdl() { cd "$@" && ls -lhFA; }

export VAGRANT_DEFAULT_PROVIDER=libvirt

if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "/usr/local/go/bin" ]; then
    PATH="/usr/local/go/bin:$PATH"
fi

if [ -d "$HOME//bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
    source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
elif [ -f /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh ]; then
    source /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
elif [ -f /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then
    source /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
fi


HOSTNAME=`hostname`
WORKBOX="Hemna-Virt"
MAC_DESKTOP="Walters-Mac-Pro.local"
MAC_LAPTOP="Walters-MacBook-Pro.local"
echo "Hello $HOSTNAME"

if [ "$HOSTNAME" == "$WORKBOX" ]; then 
    # Go
    export GOROOT="/usr/local/go"
    export GOPATH=$HOME/gocode

    export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

    alias avwx='chromium-browser --user-data-dir=~/.ass --allow-file-access-from-files --disable-web-security /home/waboring/workspace/AviationWeatherHD/index.html'

    #. ~/.liquidprompt/liquidprompt
    #(play -q -n synth sine F2 sine C3 remix - fade 0 1 .1 norm -4 bend 0.5,2399,2 fade 0 1 0.5 2&>/dev/null &)
    #(play -q -n synth sine F2 sine C3 remix - fade 0 1 .1 norm -4 bend 0.5,2399,2 fade 0 1 0.5 gain -10 2&>/dev/null &)
    #(play -q -n synth sine F2 sine C3 remix - fade 0 1 .1 norm -4 bend 0.5,2399,2 gain -10 fade 0 1 0.5  2&>/dev/null &)
    #screenfetch -A 'tux' -E
    #fortune -s -o 2>&1 > /tmp/fortune.ass
    #spd-say -e -i -50 -r +25 </tmp/fortune.ass >/dev/null
    #cat /tmp/fortune.ass|cowsay
    #rm /tmp/fortune.ass

    # Weather shit
    #curl http://wttr.in/95664
    #wego
elif [ "$HOSTNAME" == "$MAC_DESKTOP" ] || [ "$HOSTNAME" == "$MAC_LAPTOP" ]; then
    export GOROOT="/usr/local/go"
    export GOPATH=$HOME/devel/go/gocode

    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi

    alias v="mvim -v"
    export GOPATH=$HOME/go
    export PATH=$PATH:$GOPATH/bin
    #export ANDROIDSDK="/Applications/Android Studio.app/Contents/bin"
    export ANDROIDSDK=$HOME/devel/android/android-sdk
    export ANDROIDNDK=$HOME/devel/android/android-ndk-r14b/bin
    export ANDROIDNDKVER="r14b"

fi
