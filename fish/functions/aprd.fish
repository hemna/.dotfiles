# some ansible shortcuts
function aprd
  ansible-playbook -i hosts/localhost ready-deployment.yml
end
