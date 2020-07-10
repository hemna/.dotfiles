#!/usr/bin/python

import sys
import subprocess

def get_host():
    cmd = ['hostname']
    #print("sys version = %s.%s" % (sys.version_info[0],
    #      sys.version_info[1]))

    if ((sys.version_info[0] == 3) and
        (sys.version_info[1] >= 5)):
        ret = subprocess.run(cmd, stdout=subprocess.PIPE)
        host = str(ret.stdout.strip())
        return host
    else:
        return subprocess.check_output(cmd).strip()

def str_to_color(s):
    hash = 0
    for c in s:
        hash = ord(c) + ((hash << 5) - hash)

    for i in range(3):
        yield (hash >> (i * 8)) & 0xff


def generate_seqs(color):
    seq = '\033]6;1;bg;{};brightness;{}\a'
    names = ['red', 'green', 'blue']
    for name, v in zip(names, color):
        yield seq.format(name, v)


if __name__ == '__main__':
    host = get_host()
    if host:
        color = str_to_color(host)
        for seq in generate_seqs(color):
            sys.stdout.write(seq)
