resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_db_image
}


resource "yandex_compute_instance" "platform_web" {
  name        = local.local_name_vm_web
  platform_id = var.vm_web_platform_id

  resources {
    cores         = var.vms_resources.vms_resource_web.vm_web_cores
    memory        = var.vms_resources.vms_resource_web.vm_web_memory
    core_fraction = var.vms_resources.vms_resource_web.vm_web_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = true
  }

// 1) Через list с типом any
#   metadata = {
#     serial-port-enable = var.metadata_ubuntu[0]
#     ssh-keys           = var.metadata_ubuntu[1]
#   }

//2) Через map с привидением типа string в number в файле main.tf
metadata = {
    serial-port-enable = tonumber(var.metadata_ubuntu.serial_port_enable)
    ssh-keys           = var.metadata_ubuntu.ssh_keys
  }

}


resource "yandex_compute_instance" "platform_db" {
  name        = local.local_name_vm_db
  platform_id = var.vm_db_platform_id

  resources {
    cores         = var.vms_resources.vms_resource_db.vm_db_cores
    memory        = var.vms_resources.vms_resource_db.vm_db_memory
    core_fraction = var.vms_resources.vms_resource_db.vm_db_core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat = true
  }

// 1) Через list с типом any
#   metadata = {
#     serial-port-enable = var.metadata_ubuntu[0]
#     ssh-keys           = var.metadata_ubuntu[1]
#   }

//2) Через map с привидением типа string в number в файле main.tf
metadata = {
    serial-port-enable = tonumber(var.metadata_ubuntu.serial_port_enable)
    ssh-keys           = var.metadata_ubuntu.ssh_keys
  }
}