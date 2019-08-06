# some ansible shortcuts
function apcp
  ansible-playbook -i hosts/localhost config-processor-run.yml -e encrypt="" -e rekey=""
end
