# run git pull origin master in every subdirectory from .
function gp
   find . -name .git -type d -execdir git pull origin master -v ';'
end
