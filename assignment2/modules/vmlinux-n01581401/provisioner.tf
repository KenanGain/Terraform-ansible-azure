resource "null_resource" "linux_provisioner" {
  for_each = var.linux_vm_names

  depends_on = [
    azurerm_linux_virtual_machine.virtual_machine
  ]

  connection {
    type        = "ssh"
    user        = var.admin_username
    private_key = file(var.private_key_path)
    host        = azurerm_public_ip.public_ip[each.key].fqdn
  }


  provisioner "remote-exec" {
    inline = [
      "sleep 30",
      "echo $(hostname)"
    ]
  }
}
