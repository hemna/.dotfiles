#!/bin/bash

# This tmux script is to be used in conjunction with running devstack
# services.   After devstack is up, this script opens up a tmux session
# with windows for every devstack service that tails the journalctl log
# for that service

cmd_dir="$(dirname "$(readlink -e ${0})")"

session="devstack"
active_sessions=`tmux ls 2>/dev/null | grep ${session}`
services=`systemctl | grep devstack | awk '{if ($1 ~ /^devstack\@/) print $1;}'`
journal_cmd="journalctl -a -f --unit"

# see if we have an existing session with that name.
# If we do, use it, and don't create new windows.
# This prevents our tmux session from getting new windows
# to each vm every time we fire tmux.sh up
if [[ ${active_sessions:0:${#session}} == ${session} ]];
then
    # We already have a session running with that name.  use it.
    ${DEBUG:+echo} tmux select-window -t :0
    ${DEBUG:+echo} tmux attach -d -t "${session}"

else
    ${DEBUG:+echo} tmux new -d -s "${session}"
    for service in $services
    do
        ${DEBUG:+echo} tmux neww -n "${service}" "${journal_cmd} ${service}"
    done

    ${DEBUG:+echo} tmux select-window -t :0
    ${DEBUG:+echo} tmux attach -d -t "${session}"
fi

exit 0
