#!/bin/zsh
#
# System agnostic installer aliasing
#
# Assumes if you are on a mac, brew is used
# Suse = zypper
# ubuntu/debian = apt
# Redhat = yum
#

source core.sh

case $OS in
    'mac') 
        alias in='brew install'
        alias up='brew upgrade'
        ;;
    'linux')
        if [[ "$DIST" == "ubuntu" ]]; then
            alias in="apt-get install"
            alias up="apt-get upgrade"
        elif [[ "$DIST" == "suse" ]]; then
            alias in="zypper in"
            alias up="zypper up"
        elif [[ "$DIST" == "redhat" ]]; then
            alias in="yum install"
            alias up="yup upgrade"
        fi
        ;;
    *) ;;
esac
