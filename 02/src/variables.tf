###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

###ssh vars
//В задании 6 надо "Также поступите с блоком **metadata", но в случае с переменной vms_resources 
//тип map подходит тем, что хранит одинаковый тип number. metadata в main.tf содержит и number и string
//Два разных типа может хранить переменная типа list, но опять в лекциях говорили, что any - дурное решение))
//
//Приведу несколько решений:
// 1) Через list с типом any
# variable "metadata_ubuntu" {
#   type = list(any)
#   default = [1,
#             "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII1QxSausQCUOtejOVvKilQvXWjrvncfgDrkH9REvAia r2d2@MacBook-Pro-Andrew.local"
#   ]
#   description = "ssh-keygen -t ed25519"
# } 

//2) Через map с привидением типа string в number в файле main.tf
variable "metadata_ubuntu" {
  type = map(string)
  default = { 
            serial_port_enable = "1",
            ssh_keys = "ubuntu:ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAII1QxSausQCUOtejOVvKilQvXWjrvncfgDrkH9REvAia r2d2@MacBook-Pro-Andrew.local"
  }
  description = "ssh-keygen -t ed25519"
} 
