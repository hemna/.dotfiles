function gist
    # test to see if the gist token file exists?
    if not test -e ~/.git-token.fish
        echo "You need to get your git-token"
        echo "git clone http://hemna.mynetgear.com:4000/hemna/.dotfiles-private.git"
    else
        source ~/.git-token.fish
    end

    if not test -n $argv[1]
       echo "Need to provide a file to gist"
       return 
    end

	set -l file $argv[1]
    set -l input_file (realpath $argv[1])

    if not test -e $input_file
        echo "Can't read file '$input_file'"
        return
    end

    set -l input (cat $input_file | jq -R --slurp .)
    set -l json_data "{\"files\":{\"'$file'\":{\"content\":$input}}}"
    set -l tmpfile (mktemp)
    echo $json_data > $tmpfile

    #set -l jq_gist_post -R --slurp ". as $input | {\"files\":{\"'$file'\":{\"content\":$input}}}"

	set -l curl_opts -X POST https://api.github.com/gists \
        -H "Content-Type: application/json" \
		-H "Accept: application/json,application/vnd.github+json" \
		-H "Authorization: token $GITHUB_GIST_OAUTH" \
		-d "@$tmpfile"

	set -l jq_result -r '.html_url'

    #if test -n $DEBUG
    #	set curl_opts $curl_opts -v
    #end

    #echo "Curl opts = $curl_opts"
    #echo "jq_gist_post = '$jq_gist_post'"
    #echo "input = '$input'"
    #echo "json_data = '$json_data'"
    #echo "tmpfile = '$tmpfile'"

	# do stuff!
    #jq $jq_gist_post | curl -sS $curl_opts | jq $jq_result > /tmp/gist_url
    curl -sS $curl_opts | jq $jq_result > /tmp/gist_url
    #echo "done with jq"
    #cat /tmp/gist_url | pbcopy
	cat /tmp/gist_url

    rm $tmpfile
end
