# Replaced oh-my-zsh with zinit for faster startup
# install zinit first by running:
# bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

# Based off of https://github.com/robbyrussell/oh-my-zsh
# First instatll oh-my-zsh
# sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export TERM="xterm-256color"

# Timer functions
start_timer() {
    # Store current time in seconds since epoch
    TIMER_START=$(date +%s.%N)
}

stop_timer() {
    # Get current time and calculate duration
    TIMER_STOP=$(date +%s.%N)
    DURATION=$(bc -l <<< "$TIMER_STOP - $TIMER_START")
    
    # Format and display result
    echo "Execution time: ${DURATION} seconds"
}

# Path to your oh-my-zsh installation.
if [[ `uname` == 'Linux' ]]
then
  export ZSH=~/.oh-my-zsh
  export DOTFILES=~/.dotfiles
fi

if [[ `uname` == 'Darwin' ]]
then
  export ZSH=$HOME/.oh-my-zsh
  export DOTFILES=$HOME/.dotfiles
fi

#start_timer
HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
# Zsh plugins
plugins=(
#    autojump
#    autopep8
#    battery
#    bgnotify
#    catimg
    command-not-found
    colorize
#    colored-man-pages
#    docker
#    extract
#    git
#    git-extras
#    jsontools
#    python
    screen
    sudo
#    thefuck
#    tig
#    transfer
#    vagrant
    vi-mode
#    virtualenv
#   z
)

# Oh-My-Zsh plugins
# zinit snippet <URL>        # Raw Syntax with URL
# zinit snippet OMZ::<PATH>  # Shorthand OMZ/ (https://github.com/ohmyzsh/ohmyzsh/raw/master/)
# zinit snippet OMZL::<PATH> # Shorthand OMZ/lib/
# zinit snippet OMZT::<PATH> # Shorthand OMZ/themes/
# zinit snippet OMZP::<PATH> # Shorthand OMZ/plugins/
zinit ice wait
zinit snippet OMZP::/command-not-found/command-not-found.plugin.zsh
zinit ice wait
zinit snippet OMZP::/colorize/colorize.plugin.zsh
zinit ice wait
zinit snippet OMZP::/screen/screen.plugin.zsh
zinit ice wait
zinit snippet OMZP::/sudo/sudo.plugin.zsh
zinit ice wait
zinit snippet OMZP::/vi-mode/vi-mode.plugin.zsh
zinit ice wait
zinit snippet OMZ::lib/clipboard.zsh
zinit ice wait
zinit snippet OMZP::git
zinit ice wait
zinit snippet OMZP::helm
#zinit snippet OMZ::lib/termsupport.zsh

#echo "load oh my zsh"
#source $ZSH/oh-my-zsh.sh

source $DOTFILES/dotfiles.sh

# User configuration
#
ZSH_COLORIZE_STYLE="colorful"

autoload bashcompinit
bashcompinit

export VAGRANT_DEFAULT_PROVIDER=libvirt

source ~/.aliases
if [ -e ~/.dotfiles/.aliases_zsh ]; then
    source ~/.dotfiles/.aliases_zsh
fi

# add anything in the ~/.bin to the path
export PATH=$PATH:~/.bin:/sbin:~/.local/bin

# Add any local settings that aren't in .dotfiles
if [[ -s ~/.local.zsh ]]; then
    source ~/.local.zsh
fi
# echo "Loading ~/.local.zsh done"

# Disable correctall for cp
alias cp='nocorrect cp '
alias mv='nocorrect mv '
alias mkdir='nocorrect mkdir '

# Disable sharing of history between shells
unsetopt share_history
setopt extendedhistory
setopt histignoredups

# completion using arrow keys (based on history)
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# for pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

#echo "pyenv init"
#eval "$(pyenv init --path)"
# Load pyenv into the shell by adding
# the following to ~/.zshrc:
#if command -v pyenv 1>/dev/null 2>&1; then
# eval "$(pyenv init -)"
#fi
#stop_timer

export COMP_WORDBREAKS=${COMP_WORDBREAKS/:/}

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="$PATH:/Users/i530566/.local/bin:$HOME/.cargo/bin:/usr/local/opt/openssl@1.1/bin:/usr/local/opt/sqlite/bin:$PATH"
export EDITOR=vim

eval $(thefuck --alias)

# for python poetry support 
export PATH="$HOME/.poetry/bin:$PATH"

#if [[ -s ~/devel/mine/hamradio/aprsd/.venv ]]; then
  # source ~/devel/mine/hamradio/aprsd/.aprsd-venv/bin/activate
#  eval "$(~/devel/mine/hamradio/aprsd/.venv/bin/aprsd completion zsh)"
#fi


# ---- FZF -----

# Set up fzf key bindings and fuzzy completion
#eval "$(fzf --zsh)"

# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

#source ~/.dotfiles/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

#echo "start direnv"

if [ -e ~/.local-direnv.zsh ]; then
    source ~/.local-direnv.zsh
fi

# ----- Bat (better cat) -----

export BAT_THEME=OneHalfLight

# echo "done loading .zshrc"
export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export PATH="/opt/homebrew/opt/tcl-tk/bin:$PATH"

# zoxide for 'smarter cd'
#eval "$(zoxide init zsh)"

. "$HOME/.cargo/env"

source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/I530566/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/I530566/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/I530566/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/I530566/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#
#
export PATH="$(brew --prefix openssl@3)/bin:$PATH"

# Added by Windsurf
export PATH="/Users/I530566/.codeium/windsurf/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
# This takes almost a half second to load
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH=$PATH:$HOME/.local/bin

