# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 0.14.9"
}
provider "azurerm" {
  features {}

  tenant_id       = var.my_tenant_id
  subscription_id = var.my_subscription_id

}
# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.resource_prefix}ResourceGroup"
  location = var.resource_location

  tags = {
    Environment = var.environment
  }
}
# Create virtual network
resource "azurerm_virtual_network" "vnet" {
  name                = "${var.resource_prefix}Vnet"
  address_space       = [var.vnet_space]
  location            = var.resource_location
  resource_group_name = azurerm_resource_group.rg.name
  tags = {
    Environment = var.environment
  }
}
# Create subnet
resource "azurerm_subnet" "subnet" {
  name                 = "${var.resource_prefix}Subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = cidrsubnets(var.vnet_space, 2)
}
# Create public IP address
resource "azurerm_public_ip" "publicip" {
  count               = var.node_count
  name                = "${var.resource_prefix}PublicIP-${format("%02d", count.index)}"
  location            = var.resource_location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  domain_name_label   = count.index == 0 ? "${var.resource_prefix}jenkins-${format("%02d", count.index)}" : "${var.resource_prefix}target-${format("%02d", count.index)}"

  tags = {
    environment = var.environment
  }
}
# Create network security group
resource "azurerm_network_security_group" "nsg" {
  name                = "${var.resource_prefix}NetworkSecurityGroup"
  location            = var.resource_location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH_http"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "80", "8080"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = var.environment
  }
}
# Create virtual network interface card
resource "azurerm_network_interface" "nic" {
  count               = var.node_count
  name                = "${var.resource_prefix}NIC-${format("%02d", count.index)}"
  location            = var.resource_location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "${var.resource_prefix}NicConfiguration"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.publicip.*.id, count.index)
  }

  tags = {
    environment = var.environment
  }
}
# Connect the security group to the subnet
resource "azurerm_subnet_network_security_group_association" "sgassociation" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
# Create virtual machine
# Create an SSH key and create key file
resource "tls_private_key" "vm_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
resource "local_file" "cloud_pem" {
  filename        = "id_rsa"
  content         = tls_private_key.vm_ssh.private_key_pem
  file_permission = "0600"
}
resource "azurerm_linux_virtual_machine" "vmlinux" {
  count                 = var.node_count
  name                  = count.index == 0 ? "${var.resource_prefix}jenkins-${format("%02d", count.index)}" : "${var.resource_prefix}target-${format("%02d", count.index)}"
  location              = var.resource_location
  resource_group_name   = azurerm_resource_group.rg.name
  network_interface_ids = [element(azurerm_network_interface.nic.*.id, count.index)]
  size                  = var.vm_size
  os_disk {
    name                 = "myOsDisk-${count.index}"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }
  computer_name                   = count.index == 0 ? "${var.resource_prefix}jenkins-${format("%02d", count.index)}" : "${var.resource_prefix}target-${format("%02d", count.index)}"
  admin_username                  = var.host_admin
  disable_password_authentication = true
  admin_ssh_key {
    username   = var.host_admin
    public_key = tls_private_key.vm_ssh.public_key_openssh
  }
  tags = {
    environment = var.environment
  }
  provisioner "local-exec" {
    command = (
      count.index != 0 ?
      "ansible-playbook -i ${self.public_ip_address}, --private-key ${local_file.cloud_pem.filename} -u ${self.admin_username} tasks.yml" :
      "ansible-playbook -i ${self.public_ip_address}, --private-key ${local_file.cloud_pem.filename} -u ${self.admin_username} task_jenkins.yml"
    )
    environment = {
      ANSIBLE_HOST_KEY_CHECKING = "False"
      ANSIBLE_STDOUT_CALLBACK   = "debug"
    }
  }
}
output "public_IP_addresses" {
  value       = azurerm_linux_virtual_machine.vmlinux.*.public_ip_address
  description = "The first is Jenkins, others are Targets"
}
output "full_domain_name" {
  value = azurerm_public_ip.publicip.*.fqdn
}
output "tls_private_key" {
  value     = tls_private_key.vm_ssh.private_key_pem
  sensitive = true
}