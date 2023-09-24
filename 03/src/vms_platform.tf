variable "vm_image" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_platform_id" {
  type        = string
  default     = "standard-v1"
}

variable "vm_resources_for_count" {
    type    = map(map(number))
     default = {
        vms_resource = {
        vm_cores         = 2
        vm_memory        = 1
        vm_core_fraction = 5
        }
    } 
}

variable "vm_resources_for_foreach" {
  description = "vms_resources"
  type = list(object(
    {
      vm_name       = string
      cpu           = number
      ram           = number
      core_fraction = number
  }))
  default = [
    {
      vm_name  = "main"
      cpu      = 4
      ram      = 2
      core_fraction = 5
    },
    {
      vm_name  = "replica"
      cpu      = 2
      ram      = 1
      core_fraction = 20
    }
  ]
}

variable "vm_resources_storage" {
    type    = map(map(number))
     default = {
        vms_resource = {
        vm_cores         = 2
        vm_memory        = 1
        vm_core_fraction = 5
        }
    } 
}
