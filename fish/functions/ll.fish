if [ "$OS" = "mac" ]
  function ll
     ls -lhFA
  end
else
  function ll
     ls -lhFA --color=auto
  end
end
