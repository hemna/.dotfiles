function psg
    ps aux | grep -v grep |grep -i -e VSZ -e
end
