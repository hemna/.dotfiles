#!/usr/local/bin/fish

set -g -x WORK_VAG_NET "192.168.121.0/24"
set -g -x WORK_VAG_ARD_NET "192.168.245.0/24"
set -g -x WORK_DE_NET "10.160.224.0/24"
set -g -x HOME_NET "192.168.1.0/24"


if [ "$OS" = "mac" ]
  function ll
      ls -lhFA $argv
  end
else
  function ll
      ls -lhFA --color=auto $argv
  end
  function pbcopy
      xclip -selection clipboard $argv
  end
  function pbpaste
      xclip -selection clipboard -o $argv
  end
end
