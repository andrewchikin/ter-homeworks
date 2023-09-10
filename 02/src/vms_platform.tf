//переменные первой ВМ.
variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v1"
}

// переменные второй ВМ.
variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
}

variable "vm_db_platform_id" {
  type        = string
  default     = "standard-v1"
}

//общие переменные
variable "vms_resources" {
    type    = map(map(number))
     default = {
        vms_resource_web = {
        vm_web_cores         = 2
        vm_web_memory        = 1
        vm_web_core_fraction = 5
        }

        vms_resource_db = {
        vm_db_cores         = 2
        vm_db_memory        = 2
        vm_db_core_fraction = 20
        }
    } 
}

