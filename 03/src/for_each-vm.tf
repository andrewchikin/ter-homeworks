resource "yandex_compute_instance" "platform_foreach" {
  platform_id = var.vm_platform_id
  depends_on = [yandex_compute_instance.platform_count] //

  for_each = { for i in var.vm_resources_for_foreach : i.vm_name => i } //
  name          = each.value.vm_name
  resources{
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
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
