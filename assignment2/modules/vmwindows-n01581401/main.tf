resource "azurerm_availability_set" "windows_avs" {
  name                = "${var.humber_id}-windows-avs"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = var.tags
}

resource "azurerm_network_interface" "nic" {
  count               = var.windows_vm_count
  name                = "${var.humber_id}-win-nic-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }

  tags = var.tags
}

resource "azurerm_public_ip" "public_ip" {
  count               = var.windows_vm_count
  name                = "${var.humber_id}-win-pip-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.humber_id}-win-${count.index}"

  tags = var.tags
}

resource "azurerm_managed_disk" "windows_disk" {
  name                 = "${var.humber_id}-win-disk"
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = 30
}

resource "azurerm_windows_virtual_machine" "virtual_machine" {
  count               = var.windows_vm_count
  name                = "${var.humber_id}-win-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  size                = var.windows_vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
  boot_diagnostics {
    storage_account_uri = var.storage_account_uri
  }

  tags = var.tags
}

resource "azurerm_virtual_machine_extension" "antimalware" {
  name                 = "IaaSAntimalware"
  virtual_machine_id   = azurerm_windows_virtual_machine.virtual_machine[0].id
  publisher            = "Microsoft.Azure.Security"
  type                 = "IaaSAntimalware"
  type_handler_version = "1.3"

  settings = <<SETTINGS
    {
      "AntimalwareEnabled": true,
      "Exclusions": {
        "Extensions": ".log;.ldf;.mdf"
      }
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
    }
  PROTECTED_SETTINGS
}







