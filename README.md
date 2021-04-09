# Terraform Module for Azure Virtual Machine
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_virtual_machine.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_capabilities"></a> [additional\_capabilities](#input\_additional\_capabilities) | (Optional) A additional\_capabilities block | `list(any)` | `[]` | no |
| <a name="input_availability_set_id"></a> [availability\_set\_id](#input\_availability\_set\_id) | (Optional) The ID of the Availability Set in which the Virtual Machine should exist. Changing this forces a new resource to be created. | `string` | `null` | no |
| <a name="input_boot_diagnostics"></a> [boot\_diagnostics](#input\_boot\_diagnostics) | (Optional) A boot\_diagnostics block | `list(any)` | `[]` | no |
| <a name="input_delete_data_disks_on_termination"></a> [delete\_data\_disks\_on\_termination](#input\_delete\_data\_disks\_on\_termination) | (Optional) Should the Data Disks (either the Managed Disks / VHD Blobs) be deleted when the Virtual Machine is destroyed? Defaults to false. | `bool` | `false` | no |
| <a name="input_delete_os_disk_on_termination"></a> [delete\_os\_disk\_on\_termination](#input\_delete\_os\_disk\_on\_termination) | (Optional) Should the OS Disk (either the Managed Disk / VHD Blob) be deleted when the Virtual Machine is destroyed? Defaults to false. | `bool` | `false` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | (Optional) A identity block | `list(any)` | `[]` | no |
| <a name="input_license_type"></a> [license\_type](#input\_license\_type) | (Optional) Specifies the BYOL Type for this Virtual Machine. This is only applicable to Windows Virtual Machines. Possible values are Windows\_Client and Windows\_Server | `string` | `null` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the Azure Region where the Virtual Machine exists. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the Virtual Machine. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_network_interface_ids"></a> [network\_interface\_ids](#input\_network\_interface\_ids) | (Required) A list of Network Interface ID's which should be associated with the Virtual Machine. | `list(string)` | n/a | yes |
| <a name="input_os_profile"></a> [os\_profile](#input\_os\_profile) | (Optional) An os\_profile block. Required when create\_option in the storage\_os\_disk block is set to FromImage | `any` | `{}` | no |
| <a name="input_os_profile_linux_config"></a> [os\_profile\_linux\_config](#input\_os\_profile\_linux\_config) | (Required, when a Linux machine) A os\_profile\_linux\_config block. | `any` | `{}` | no |
| <a name="input_os_profile_secrets"></a> [os\_profile\_secrets](#input\_os\_profile\_secrets) | (Optional) One or more os\_profile\_secrets blocks | `list(any)` | `[]` | no |
| <a name="input_os_profile_windows_config"></a> [os\_profile\_windows\_config](#input\_os\_profile\_windows\_config) | (Required, when a Windows machine) A os\_profile\_windows\_config block. | `any` | `{}` | no |
| <a name="input_plan"></a> [plan](#input\_plan) | (Optional) A plan block | `list(any)` | `[]` | no |
| <a name="input_primary_network_interface_id"></a> [primary\_network\_interface\_id](#input\_primary\_network\_interface\_id) | (Optional) The ID of the Network Interface (which must be attached to the Virtual Machine) which should be the Primary Network Interface for this Virtual Machine. | `string` | `null` | no |
| <a name="input_proximity_placement_group_id"></a> [proximity\_placement\_group\_id](#input\_proximity\_placement\_group\_id) | (Optional) The ID of the Proximity Placement Group to which this Virtual Machine should be assigned. Changing this forces a new resource to be created | `string` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) Specifies the name of the Resource Group in which the Virtual Machine should exist. Changing this forces a new resource to be created. | `string` | n/a | yes |
| <a name="input_storage_data_disk"></a> [storage\_data\_disk](#input\_storage\_data\_disk) | (Optional) One or more storage\_data\_disk blocks | `list(any)` | `[]` | no |
| <a name="input_storage_image_reference"></a> [storage\_image\_reference](#input\_storage\_image\_reference) | (Optional) A storage\_image\_reference block | `any` | `{}` | no |
| <a name="input_storage_os_disk"></a> [storage\_os\_disk](#input\_storage\_os\_disk) | (Required) A storage\_os\_disk block. | `any` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the Virtual Machine. | `map(string)` | `{}` | no |
| <a name="input_vm_size"></a> [vm\_size](#input\_vm\_size) | (Required) Specifies the size of the Virtual Machine | `string` | n/a | yes |
| <a name="input_zones"></a> [zones](#input\_zones) | (Optional) A list of a single item of the Availability Zone which the Virtual Machine should be allocated in. | `list(string)` | `[]` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
