# cache dir for updates
if [[ -z "$DOTFILES_CACHE_DIR" ]]; then
    DOTFILES_CACHE_DIR="$DOTFILES/cache"
fi

# Check for updates on initial load...
if [ "$DISABLE_AUTO_UPDATE" != "true" ]; then
    env ZSH=$ZSH DOTFILES_CACHE_DIR=$DOTFILES_CACHE_DIR DISABLE_UPDATE_PROMPT=$DISABLE_UPDATE_PROMPT zsh -f $DOTFILES/tools/check_for_upgrade.sh
fi
