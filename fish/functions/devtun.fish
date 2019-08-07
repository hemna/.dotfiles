function devtun
    command sshuttle -e 'ssh -X' -r waboring@10.84.128.34 $WORK_VAG_NET $WORK_VAG_ARD_NET $WORK_DE_NET
end
