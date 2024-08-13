resource "null_resource" "ansible_provision" {
  depends_on = [module.linux_vms]

  provisioner "local-exec" {
    environment = {
      ANSIBLE_CONFIG = "/home/n01581401/automation/ansible2/ansible.cfg"
    }
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i /home/n01581401/automation/ansible2/hosts /home/n01581401/automation/ansible2/n01581401-playbook.yml --private-key=/home/n01581401/.ssh/id_rsa"
  }
}
