resource yandex_compute_disk "disks"{
  count    = 3 //
  name     = "disk-${count.index+1}" //
  size     = 1
}

resource "yandex_compute_instance" "storage" {
  platform_id = var.vm_platform_id
  name = "storage"//
  depends_on = [yandex_compute_disk.disks] //
  resources {
    cores         = var.vm_resources_storage.vms_resource.vm_cores
    memory        = var.vm_resources_storage.vms_resource.vm_memory
    core_fraction = var.vm_resources_storage.vms_resource.vm_core_fraction
  }

  dynamic "secondary_disk"{
    for_each = yandex_compute_disk.disks.*.id
    content{
        disk_id= secondary_disk.value
    }
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
  
    metadata = {
    serial_port_enable = tonumber(var.metadata_ubuntu.serial_port_enable)
    ssh_keys           = local.ssh_file
  }

}