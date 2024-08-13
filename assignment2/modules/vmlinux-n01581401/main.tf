resource "azurerm_availability_set" "linux_avs" {
  name                = "${var.humber_id}-linux-avs"
  location            = var.location
  resource_group_name = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true
  tags                = var.tags
}

resource "azurerm_network_interface" "nic" {
  for_each            = var.linux_vm_names
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[each.key].id
  }

  tags = var.tags
}

resource "azurerm_public_ip" "public_ip" {
  for_each            = var.linux_vm_names
  name                = "${each.key}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method = "Static"
  sku               = "Standard"

  domain_name_label   = "${each.key}-${var.humber_id}"

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "virtual_machine" {
  for_each            = var.linux_vm_names
  name                = each.key
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]
  size                = var.linux_vm_size
  admin_username      = var.admin_username
  admin_ssh_key {
    username   = var.admin_username
    public_key = file(var.public_key_path)
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7_9-gen2"
    version   = "latest"
  }
  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "network_watcher" {
  for_each            = var.linux_vm_names
  name                = "NetworkWatcherAgentLinux"
  virtual_machine_id  = azurerm_linux_virtual_machine.virtual_machine[each.key].id
  publisher           = "Microsoft.Azure.NetworkWatcher"
  type                = "NetworkWatcherAgentLinux"
  type_handler_version = "1.4"

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "azure_monitor" {
  for_each            = var.linux_vm_names
  name                = "AzureMonitorLinuxAgent"
  virtual_machine_id  = azurerm_linux_virtual_machine.virtual_machine[each.key].id
  publisher           = "Microsoft.Azure.Monitor"
  type                = "AzureMonitorLinuxAgent"
  type_handler_version = "1.2"
  auto_upgrade_minor_version = true

  tags = var.tags
}







