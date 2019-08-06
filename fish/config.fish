# My custom fish init 
# 
# The old bash aliases are now functions
# in ~/.config/fish/functions
#
# Use fisher for the package manager
#
# see common/cool fish functions/packages
# https://github.com/jorgebucaran/awesome-fish

source ~/.dotfiles/lib/core.fish

#  
set -g -x WORK_VAG_NET "192.168.121.0/24"
set -g -x WORK_VAG_ARD_NET "192.168.245.0/24"
set -g -x WORK_DE_NET "10.160.224.0/24"
set -g -x HOME_NET "192.168.1.0/24"

set -g -x GITHUB_USER hemna

if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# virtualfish support here
#  https://virtualfish.readthedocs.io/en/latest/index.html
# virtualfish plugins
# https://virtualfish.readthedocs.io/en/latest/plugins.html
eval (python3 -m virtualfish auto_activation)
