locals {
  virtual_machine = var.linux_vm ? {
    id                   = try(azurerm_linux_virtual_machine.this[0].id, null)
    identity             = try(azurerm_linux_virtual_machine.this[0].identity, null)
    private_ip_address   = try(azurerm_linux_virtual_machine.this[0].private_ip_address, null)
    private_ip_addresses = try(azurerm_linux_virtual_machine.this[0].private_ip_addresses, null)
    public_ip_address    = try(azurerm_linux_virtual_machine.this[0].public_ip_address, null)
    public_ip_addresses  = try(azurerm_linux_virtual_machine.this[0].public_ip_addresses, null)
    virtual_machine_id   = try(azurerm_linux_virtual_machine.this[0].virtual_machine_id, null)
  } : {}
}
