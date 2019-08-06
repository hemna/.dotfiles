#!/usr/local/bin/fish

function shootProfile
    set -x OS (uname)
    set -x OS (string lower $OS)
    set -x KERNEL (uname -r)
    set -x MACH (uname -m)

    echo "OS = '$OS'"

    switch "$OS"
    case "windowsnt"
        echo "FUcking windows"
        set -g -x OS 'windows'
    case "darwin"
        echo "FUcking MAC"
        set -g -x OS 'mac'
        set -g -x DIST "apple"
        set -g -x ARCH (uname -p)
        set -g -x KERNEL (uname -v)
        set -g -x DistroBasedOn 'RedHat'
        set -g -x REV (sw_vers | grep ProductVersion | awk '{ print $2 }')
    case "sunos"
        echo "FUcking SUN"
        set -g -x OS 'Solaris'
        set -g -x ARCH (uname -p)
        set -g -x OSSTR "$OS $REV($ARCH (uname -v))"
    case "aix"
        echo "FUcking AIX"
        set -g -x OSSTR "$OS (oslevel) ((oslevel -r))"
    case "linux"
        echo "FUcking LINUX"
        if test -e /etc/redhat-release
            set -g -x DistroBasedOn 'RedHat'
            set -g -x DIST (cat /etc/redhat-release |sed s/\ release.*//)
            set -g -x PSEUDONAME (cat /etc/redhat-release | sed s/.*\(// | sed s/\)//)
            set -g -x REV (cat /etc/redhat-release | sed s/.*release\ // | sed s/\ .*//)
        else if test -e /etc/SuSE-release
            set -g -x DIST 'suse'
            set -g -x DistroBasedOn 'SuSe'
            set -g -x PSEUDONAME (lsb_release -a | grep Description | cut -f2-)
            set -g -x REV (lsb_release -a | grep Release | cut -f2-)
        else if test -e /etc/mandrake-release
            set -g -x DistroBasedOn 'Mandrake'
            set -g -x PSEUDONAME (cat /etc/mandrake-release | sed s/.*\(// | sed s/\)//)
            set -g -x REV (cat /etc/mandrake-release | sed s/.*release\ // | sed s/\ .*//)
        else if test -e /etc/debian_version
            set -g -x DistroBasedOn 'Debian'
            if test -e /etc/lsb-release
                set -g -x DIST (cat /etc/lsb-release | grep '^DISTRIB_ID' | awk -F=  '{ print $2 }')
                set -g -x PSEUDONAME (cat /etc/lsb-release | grep '^DISTRIB_CODENAME' | awk -F=  '{ print $2 }')
                set -g -x REV (cat /etc/lsb-release | grep '^DISTRIB_RELEASE' | awk -F=  '{ print $2 }')
            end
            if test -e /etc/UnitedLinux-release
                set -g -x DIST "$DIST[eval(cat /etc/UnitedLinux-release | tr "\n" ' ' | sed s/VERSION.*//)]"
            end
        end
        set -g -x DIST (lowercase $DIST)
        set -g -x DistroBasedOn (lowercase $DistroBasedOn)
        readonly OS
        readonly DIST
        readonly DistroBasedOn
        readonly PSEUDONAME
        readonly REV
        readonly KERNEL
        readonly MACH
    end
end

shootProfile
#echo "OS: $OS"
#echo "DIST: $DIST"
#echo "PSUEDONAME: $PSUEDONAME"
#echo "REV: $REV"
#echo "DistroBasedOn: $DistroBasedOn"
#echo "KERNEL: $KERNEL"
#echo "MACH: $MACH"
#echo "========"
