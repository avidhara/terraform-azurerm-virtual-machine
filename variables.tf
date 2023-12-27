variable "linux_vm" {
  type        = bool
  description = "(Optional) Do you want to provision a Linux Virtual Machine? Defaults to true."
  default     = true
}

variable "admin_username" {
  type        = string
  description = "(Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created."
  nullable    = false
}

variable "location" {
  type        = string
  description = "(Required) The Azure location where the Linux Virtual Machine should exist. Changing this forces a new resource to be created."
  nullable    = false
}

variable "license_type" {
  type        = string
  description = "(Optional) Specifies the BYOL Type for this Virtual Machine. Possible values are RHEL_BYOS and SLES_BYOS."
  default     = null
}

variable "name" {
  type        = string
  description = "(Required) The name of the Linux Virtual Machine. Changing this forces a new resource to be created."
  nullable    = false
}

variable "network_interface_ids" {
  type        = list(string)
  description = "(Required). A list of Network Interface IDs which should be attached to this Virtual Machine. The first Network Interface ID in this list will be the Primary Network Interface on the Virtual Machine."
}

variable "os_disk" {
  type = object({
    caching                          = string
    storage_account_type             = string
    disk_encryption_set_id           = optional(string)
    disk_size_gb                     = optional(number)
    name                             = optional(string)
    secure_vm_disk_encryption_set_id = optional(string)
    security_encryption_type         = optional(string)
    write_accelerator_enabled        = optional(bool, false)
    diff_disk_settings = optional(object({
      option    = string
      placement = optional(string)
    }), null)
  })
  description = <<-EOT
  object({
    caching                          = "(Required) The Type of Caching which should be used for the Internal OS Disk. Possible values are `None`, `ReadOnly` and `ReadWrite`."
    storage_account_type             = "(Required) The Type of Storage Account which should back this the Internal OS Disk. Possible values are `Standard_LRS`, `StandardSSD_LRS`, `Premium_LRS`, `StandardSSD_ZRS` and `Premium_ZRS`. Changing this forces a new resource to be created."
    disk_encryption_set_id           = "(Optional) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk. Conflicts with `secure_vm_disk_encryption_set_id`. The Disk Encryption Set must have the `Reader` Role Assignment scoped on the Key Vault - in addition to an Access Policy to the Key Vault"
    disk_size_gb                     = "(Optional) The Size of the Internal OS Disk in GB, if you wish to vary from the size used in the image this Virtual Machine is sourced from. If specified this must be equal to or larger than the size of the Image the Virtual Machine is based on. When creating a larger disk than exists in the image you'll need to repartition the disk to use the remaining space."
    name                             = "(Optional) The name which should be used for the Internal OS Disk. Changing this forces a new resource to be created."
    secure_vm_disk_encryption_set_id = "(Optional) The ID of the Disk Encryption Set which should be used to Encrypt this OS Disk when the Virtual Machine is a Confidential VM. Conflicts with `disk_encryption_set_id`. Changing this forces a new resource to be created. `secure_vm_disk_encryption_set_id` can only be specified when `security_encryption_type` is set to `DiskWithVMGuestState`."
    security_encryption_type         = "(Optional) Encryption Type when the Virtual Machine is a Confidential VM. Possible values are `VMGuestStateOnly` and `DiskWithVMGuestState`. Changing this forces a new resource to be created. `vtpm_enabled` must be set to `true` when `security_encryption_type` is specified. `encryption_at_host_enabled` cannot be set to `true` when `security_encryption_type` is set to `DiskWithVMGuestState`."
    write_accelerator_enabled        = "(Optional) Should Write Accelerator be Enabled for this OS Disk? Defaults to `false`. This requires that the `storage_account_type` is set to `Premium_LRS` and that `caching` is set to `None`."
    diff_disk_settings               = optional(object({
      option    = "(Required) Specifies the Ephemeral Disk Settings for the OS Disk. At this time the only possible value is `Local`. Changing this forces a new resource to be created."
      placement = "(Optional) Specifies where to store the Ephemeral Disk. Possible values are `CacheDisk` and `ResourceDisk`. Defaults to `CacheDisk`. Changing this forces a new resource to be created."
    }), [])
  })
  EOT
  nullable    = false
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which the Linux Virtual Machine should be exist. Changing this forces a new resource to be created."
  nullable    = false
}

variable "size" {
  type        = string
  description = "(Required) The SKU which should be used for this Virtual Machine, such as Standard_F2."
  nullable    = false
}

variable "additional_capabilities" {
  type = object({
    ultra_ssd_enabled = optional(bool, false)
  })
  description = <<-EOT
  object({
    ultra_ssd_enabled = (Optional) Should the capacity to enable Data Disks of the UltraSSD_LRS storage account type be supported on this Virtual Machine? Defaults to false.
  })
  EOT
  default     = null
}

variable "admin_password" {
  type        = string
  description = "(Optional) The Password which should be used for the local-administrator on this Virtual Machine. Changing this forces a new resource to be created. When an admin_password is specified disable_password_authentication must be set to false. ~> NOTE: One of either admin_password or admin_ssh_key must be specified."
  default     = null
  sensitive   = true
}

variable "admin_ssh_key" {
  type = list(object({
    public_key = string
    username   = string
  }))
  description = <<-EOT
  list(object({
    public_key =  (Required) The Public Key which should be used for authentication, which needs to be at least 2048-bit and in ssh-rsa format. Changing this forces a new resource to be created.
    username = (Required) The Username for which this Public SSH Key should be configured. Changing this forces a new resource to be created.
  }))
  EOT
  default     = []
}

variable "allow_extension_operations" {
  type        = bool
  description = "(Optional) Should Extension Operations be allowed on this Virtual Machine? Defaults to false."
  default     = false
}

variable "availability_set_id" {
  type        = string
  description = "(Optional) Specifies the ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created."
  default     = null
}

variable "boot_diagnostics" {
  type = object({
    storage_account_uri = optional(string)
  })
  description = <<-EOT
  object({
    storage_account_uri = (Optional) The Primary/Secondary Endpoint for the Azure Storage Account which should be used to store Boot Diagnostics, including Console Output and Screenshots from the Hypervisor.
  })
  EOT
  default     = {}
}

variable "bypass_platform_safety_checks_on_user_schedule_enabled" {
  type        = bool
  description = "(Optional) Specifies whether to skip platform scheduled patching when a user schedule is associated with the VM. Defaults to false."
  default     = false
  nullable    = false
}

variable "capacity_reservation_group_id" {
  type        = string
  description = "(Optional) Specifies the ID of the Capacity Reservation Group which the Virtual Machine should be allocated to."
  default     = null
}

variable "computer_name" {
  type        = string
  description = "(Optional) Specifies the Hostname which should be used for this Virtual Machine. If unspecified this defaults to the value for the name field. If the value of the name field is not a valid computer_name, then you must specify computer_name. Changing this forces a new resource to be created."
  default     = null
}

variable "custom_data" {
  type        = string
  description = "(Optional) The Base64-Encoded Custom Data which should be used for this Virtual Machine. Changing this forces a new resource to be created."
  default     = null

  validation {
    condition     = var.custom_data == null ? true : can(base64decode(var.custom_data))
    error_message = "The `custom_data` must be either `null` or a valid Base64-Encoded string."
  }
}

variable "dedicated_host_id" {
  type        = string
  description = "(Optional) The ID of a Dedicated Host where this machine should be run on. Conflicts with dedicated_host_group_id."
  default     = null
}

variable "dedicated_host_group_id" {
  type        = string
  description = "(Optional) The ID of a Dedicated Host Group that this Linux Virtual Machine should be run within. Conflicts with dedicated_host_id."
  default     = null
}

variable "disable_password_authentication" {
  type        = bool
  description = "(Optional) Should Password Authentication be disabled on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created."
  default     = true
}

variable "edge_zone" {
  type        = string
  description = "(Optional) Specifies the Edge Zone within the Azure Region where this Linux Virtual Machine should exist. Changing this forces a new Linux Virtual Machine to be created."
  default     = null
}

variable "encryption_at_host_enabled" {
  type        = bool
  description = "(Optional) Should all of the disks (including the temp disk) attached to this Virtual Machine be encrypted by enabling Encryption at Host?"
  default     = null
}

variable "eviction_policy" {
  type        = string
  description = "(Optional) Specifies what should happen when the Virtual Machine is evicted for price reasons when using a Spot instance. Possible values are Deallocate and Delete. Changing this forces a new resource to be created."
  default     = null
}

variable "extensions_time_budget" {
  type        = string
  description = "(Optional) Specifies the duration allocated for all extensions to start. The time duration should be between 15 minutes and 120 minutes (inclusive) and should be specified in ISO 8601 format. Defaults to PT1H30M."
  default     = "PT1H30M"
}

variable "gallery_application" {
  type = list(object({
    version_id             = string
    configuration_blob_uri = optional(string)
    order                  = optional(number, 0)
    tag                    = optional(string)
  }))
  description = <<-EOT
  list(object({
    version_id      = (Required) Specifies the Gallery Application Version resource ID.
    configuration_blob_uri = (Optional) Specifies the URI to an Azure Blob that will replace the default configuration for the package if provided.
    order = (Optional) Specifies the order in which the packages have to be installed. Possible values are between 0 and 2,147,483,647. Defaults to 0.
    tag = (Optional) Specifies a passthrough value for more generic context. This field can be any valid string value.
  }))
  EOT
  default     = []
}

variable "identity" {
  type = object({
    type         = string
    identity_ids = optional(list(string), [])
  })
  description = <<-EOT
  object({
    type =  (Required) Specifies the type of Managed Service Identity that should be configured on this Linux Virtual Machine. Possible values are SystemAssigned, UserAssigned, SystemAssigned, UserAssigned (to enable both).
    identity_ids = (Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Linux Virtual Machine.
  })
  EOT
  default     = null
}

variable "patch_assessment_mode" {
  type        = string
  description = "(Optional) Specifies the mode of VM Guest Patching for the Virtual Machine. Possible values are AutomaticByPlatform or ImageDefault. Defaults to ImageDefault."
  default     = "ImageDefault"
}


variable "patch_mode" {
  type        = string
  description = "(Optional) Specifies the mode of in-guest patching to this Linux Virtual Machine. Possible values are AutomaticByPlatform and ImageDefault. Defaults to ImageDefault. "
  default     = null
}

variable "max_bid_price" {
  type        = number
  description = "(Optional) The maximum price you're willing to pay for this Virtual Machine, in US Dollars; which must be greater than the current spot price. If this bid price falls below the current spot price the Virtual Machine will be evicted using the eviction_policy. Defaults to -1, which means that the Virtual Machine should not be evicted for price reasons."
  default     = -1
}

variable "plan" {
  type = object({
    name      = string
    product   = string
    publisher = string
  })
  description = <<-EOT
  object({
    name      = (Required) Specifies the Name of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
    product   = (Required) Specifies the Product of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
    publisher = (Required) Specifies the Publisher of the Marketplace Image this Virtual Machine should be created from. Changing this forces a new resource to be created.
  })
  EOT
  default     = null
}

variable "platform_fault_domain" {
  type        = number
  description = "Optional) Specifies the Platform Fault Domain in which this Linux Virtual Machine should be created. Defaults to -1, which means this will be automatically assigned to a fault domain that best maintains balance across the available fault domains. Changing this forces a new Linux Virtual Machine to be created."
  default     = null
}

variable "priority" {
  type        = string
  description = "(Optional) Specifies the priority of this Virtual Machine. Possible values are Regular and Spot. Defaults to Regular. Changing this forces a new resource to be created."
  default     = "Regular"
}

variable "provision_vm_agent" {
  type        = bool
  description = "(Optional) Should the Azure VM Agent be provisioned on this Virtual Machine? Defaults to true. Changing this forces a new resource to be created."
  default     = true
}

variable "proximity_placement_group_id" {
  type        = string
  description = "(Optional) The ID of the Proximity Placement Group which the Virtual Machine should be assigned to."
  default     = null
}

variable "reboot_setting" {
  type        = string
  description = "(Optional) Specifies the reboot setting for platform scheduled patching. Possible values are Always, IfRequired and Never."
  default     = null

  validation {
    condition     = var.reboot_setting == null ? true : contains(["Always", "IfRequired", "Never"], var.reboot_setting)
    error_message = "`var.reboot_setting` is not a valid value. Use one of: `Always`, `IfRequired`, `Never`"
  }
}

variable "secret" {
  type = list(object({
    certificate = list(object({
      url = string
    }))
    key_vault_id = string
  }))
  description = <<-EOT
  list(object({
    certificate = list(object({
      url   = (Required) The Secret URL of a Key Vault Certificate.
    }))
    key_vault_id = (Required) The ID of the Key Vault from which all Secrets should be sourced.
  }))
  EOT
  default     = []
}

variable "secure_boot_enabled" {
  type        = bool
  description = "(Optional) Specifies whether secure boot should be enabled on the virtual machine. Changing this forces a new resource to be created."
  default     = null
}

variable "source_image_id" {
  type        = string
  description = "(Optional) The ID of the Image which this Virtual Machine should be created from. Changing this forces a new resource to be created. Possible Image ID types include Image IDs, Shared Image IDs, Shared Image Version IDs, Community Gallery Image IDs, Community Gallery Image Version IDs, Shared Gallery Image IDs and Shared Gallery Image Version IDs."
  default     = null
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = <<-EOT
  object({
    publisher = (Required) Specifies the publisher of the image used to create the virtual machines. Changing this forces a new resource to be created.
    offer     = (Required) Specifies the offer of the image used to create the virtual machines. Changing this forces a new resource to be created.
    sku       = (Required) Specifies the SKU of the image used to create the virtual machines. Changing this forces a new resource to be created.
    version   = (Required) Specifies the version of the image used to create the virtual machines. Changing this forces a new resource to be created.
  })
  EOT
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags which should be assigned to this Virtual Machine."
  default     = {}
}

variable "termination_notification" {
  type = object({
    enabled = bool
    timeout = optional(string, "PT5M")
  })
  description = <<-EOT
  object({
    enabled = (Required) Should the termination notification be enabled on this Virtual Machine?
    timeout = (Optional) Length of time (in minutes, between 5 and 15) a notification to be sent to the VM on the instance metadata server till the VM gets deleted. The time duration should be specified in ISO 8601 format. Defaults to PT5M.
  })
  EOT
  default     = null
}

variable "user_data" {
  type        = string
  description = "Optional) The Base64-Encoded User Data which should be used for this Virtual Machine."
  default     = null

  validation {
    condition     = var.user_data == null ? true : can(base64decode(var.user_data))
    error_message = "`user_data` must be either `null` or valid base64 encoded string."
  }
}

variable "vtpm_enabled" {
  type        = bool
  description = "(Optional) Specifies whether vTPM should be enabled on the virtual machine. Changing this forces a new resource to be created."
  default     = null
}

variable "virtual_machine_scale_set_id" {
  type        = string
  description = "(Optional) Specifies the Orchestrated Virtual Machine Scale Set that this Virtual Machine should be created within. Changing this forces a new resource to be created."
  default     = null
}

variable "zone" {
  type        = string
  description = "(Optional) Specifies the Availability Zones in which this Linux Virtual Machine should be located. Changing this forces a new Linux Virtual Machine to be created."
  default     = null
}
