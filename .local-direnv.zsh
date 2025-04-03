venv() {
    local venv_name
    local dir_name=$(basename "$PWD")

    # If there are no arguments or the last argument starts with a dash, use dir_name
    if [ $# -eq 0 ] || [[ "${!#}" == -* ]]; then
        venv_name="$dir_name"
    else
        venv_name="${!#}"
        set -- "${@:1:$#-1}"
    fi

    # Check if .envrc already exists
    if [ -f .envrc ]; then
        echo "Error: .envrc already exists" >&2
        return 1
    fi

    # Create venv using uv with all passed arguments
    if ! uv venv --seed --prompt "$@" "$venv_name"; then
        echo "Error: Failed to create venv" >&2
        return 1
    fi

    # Create .envrc
    echo "layout python" > .envrc

    # Append to ~/.projects
    echo "${venv_name} = ${PWD}" >> ~/.projects

    # Allow direnv to immediately activate the virtual environment
    direnv allow
}

#
# Add direnv-activated venv to prompt
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV_PROMPT" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV_PROMPT)) "
  fi
}
PS1='$(show_virtual_env)'$PS1


eval "$(direnv hook zsh)"
