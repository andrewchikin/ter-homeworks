data "yandex_compute_image" "ubuntu" {
  family = var.vm_image
}

resource "yandex_compute_instance" "platform_count" {
  
  platform_id = var.vm_platform_id
  count       = 2 //
  name        = "platform-web-${count.index+1}" //
  depends_on = [yandex_vpc_security_group.example]

  resources {
    cores         = var.vm_resources_for_count.vms_resource.vm_cores
    memory        = var.vm_resources_for_count.vms_resource.vm_memory
    core_fraction = var.vm_resources_for_count.vms_resource.vm_core_fraction
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
    security_group_ids = [yandex_vpc_security_group.example.id] //
    nat = true
  } 
  
metadata = {
    serial_port_enable = tonumber(var.metadata_ubuntu.serial_port_enable)
    ssh_keys           = local.ssh_file
  }

}