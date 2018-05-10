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
        alias install='brew install'
        alias upgrade='brew upgrade'
        ;;
    'linux')
        if [[ "$DIST" == "ubuntu" ]]; then
            alias install="apt-get install"
            alias upgrade="apt-get upgrade"
        elif [[ "$DIST" == "suse" ]]; then
            alias install="zypper in"
            alias upgrade="zypper up"
        elif [[ "$DIST" == "redhat" ]]; then
            alias install="yum install"
            alias upgrade="yup upgrade"
        fi
        ;;
    *) ;;
esac
