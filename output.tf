output "id" {
  description = "The ID of the Linux Virtual Machine."
  value       = local.virtual_machine.id
}

output "identity" {
  description = "An identity block as documented below."
  value       = local.virtual_machine.identity
}

output "private_ip_address" {
  description = "The Primary Private IP Address assigned to this Virtual Machine."
  value       = local.virtual_machine.private_ip_address
}

output "private_ip_addresses" {
  description = "A list of Private IP Addresses assigned to this Virtual Machine."
  value       = local.virtual_machine.private_ip_addresses
}

output "public_ip_address" {
  description = "The Primary Public IP Address assigned to this Virtual Machine."
  value       = local.virtual_machine.public_ip_address
}

output "public_ip_addresses" {
  description = "A list of the Public IP Addresses assigned to this Virtual"
  value       = local.virtual_machine.public_ip_addresses
}

output "virtual_machine_id" {
  description = "A 128-bit identifier which uniquely identifies this Virtual Machine."
  value       = local.virtual_machine.virtual_machine_id
}
