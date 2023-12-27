resource "azurerm_linux_virtual_machine" "this" {
  count = var.linux_vm ? 1 : 0

  admin_username        = var.admin_username
  location              = var.location
  license_type          = var.license_type
  name                  = var.name
  network_interface_ids = var.network_interface_ids

  os_disk {
    caching                          = var.os_disk.caching
    storage_account_type             = var.os_disk.storage_account_type
    disk_encryption_set_id           = var.os_disk.disk_encryption_set_id
    disk_size_gb                     = var.os_disk.disk_size_gb
    name                             = var.os_disk.name
    secure_vm_disk_encryption_set_id = var.os_disk.secure_vm_disk_encryption_set_id # conflicts with disk_encryption_set_id
    security_encryption_type         = var.vtpm_enabled ? var.os_disk.security_encryption_type : null
    write_accelerator_enabled        = var.os_disk.write_accelerator_enabled
    dynamic "diff_disk_settings" {
      for_each = var.os_disk.caching == "ReadOnly" && var.os_disk.diff_disk_settings != null ? [var.os_disk.diff_disk_settings] : []
      content {
        option    = try(diff_disk_settings.value.option)
        placement = try(diff_disk_settings.value.placement, "CacheDisk")
      }
    }

  }

  resource_group_name = var.resource_group_name
  size                = var.size

  dynamic "additional_capabilities" {
    for_each = var.additional_capabilities
    content {

    }
  }

  admin_password = var.admin_password

  dynamic "admin_ssh_key" {
    for_each = var.admin_ssh_key

    content {
      public_key = try(admin_ssh_key.value.public_key)
      username   = try(admin_ssh_key.value.username)

    }
  }

  allow_extension_operations = var.allow_extension_operations
  availability_set_id        = var.availability_set_id

  dynamic "boot_diagnostics" {
    for_each = length(var.boot_diagnostics) > 0 ? [var.boot_diagnostics] : []
    content {
      storage_account_uri = try(boot_diagnostics.value.storage_account_uri)
    }
  }

  bypass_platform_safety_checks_on_user_schedule_enabled = var.bypass_platform_safety_checks_on_user_schedule_enabled
  capacity_reservation_group_id                          = var.capacity_reservation_group_id # Conflicts with availability_set_id
  computer_name                                          = var.computer_name
  custom_data                                            = var.custom_data
  dedicated_host_id                                      = var.dedicated_host_id
  dedicated_host_group_id                                = var.dedicated_host_group_id
  disable_password_authentication                        = var.disable_password_authentication
  edge_zone                                              = var.edge_zone
  encryption_at_host_enabled                             = var.encryption_at_host_enabled
  eviction_policy                                        = var.eviction_policy
  extensions_time_budget                                 = var.extensions_time_budget

  dynamic "gallery_application" {
    for_each = var.gallery_application
    content {
      version_id             = try(gallery_application.value.version_id)
      configuration_blob_uri = try(gallery_application.value.configuration_blob_uri)
      order                  = try(gallery_application.value.order)
      tag                    = try(gallery_application.value.tag)

    }
  }

  dynamic "identity" {
    for_each = var.identity != null ? [var.identity] : []
    content {
      type         = try(identity.value.type)
      identity_ids = try(identity.value.identity_ids)
    }
  }

  patch_assessment_mode = var.patch_assessment_mode
  patch_mode            = var.patch_mode
  max_bid_price         = var.max_bid_price

  dynamic "plan" {
    for_each = var.plan != null ? [var.plan] : []
    content {
      name      = try(plan.value.name)
      product   = try(plan.value.product)
      publisher = try(plan.value.publisher)

    }
  }

  platform_fault_domain        = var.platform_fault_domain
  priority                     = var.priority
  provision_vm_agent           = var.provision_vm_agent
  proximity_placement_group_id = var.proximity_placement_group_id
  reboot_setting               = var.reboot_setting

  dynamic "secret" {
    for_each = var.secret
    content {
      key_vault_id = try(secret.value.key_vault_id)
      dynamic "certificate" {
        for_each = [secret.value.certificate]
        content {
          url = try(certificate.value.url)
        }

      }

    }
  }

  secure_boot_enabled = var.secure_boot_enabled
  source_image_id     = var.source_image_id

  dynamic "source_image_reference" {
    for_each = var.source_image_reference != null ? [var.source_image_reference] : []
    content {
      publisher = try(source_image_reference.value.publisher)
      offer     = try(source_image_reference.value.offer)
      sku       = try(source_image_reference.value.sku)
      version   = try(source_image_reference.value.version)
    }
  }
  tags = var.tags

  dynamic "termination_notification" {
    for_each = var.termination_notification != null ? [var.termination_notification] : []
    content {
      enabled = try(termination_notification.value.enabled)
      timeout = try(termination_notification.value.timeout)
    }
  }

  user_data                    = var.user_data
  vtpm_enabled                 = var.vtpm_enabled
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_id
  zone                         = var.zone
}
