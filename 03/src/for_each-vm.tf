# # Создайте файл for_each-vm.tf. Опишите в нём создание двух ВМ с именами "main" и "replica" **разных** по cpu/ram/disk , 
# используя мета-аргумент **for_each loop**. Используйте для обеих ВМ одну общую переменную типа 
# list(object({ vm_name=string, cpu=number, ram=number, disk=number  })). 
# При желании внесите в переменную все возможные параметры.

#   for_each = { main = {cpu = 2, ram = 1, fraction= 20}, 
#                replica = {cpu = 4, ram = 2, fraction = 5} 
#   }
#   name = "${each.key}"
#   resources {
#     cores         = "${each.value.cpu}"
#     memory        = "${each.value.ram}"
#     core_fraction = "${each.value.fraction}"
#   }

#   resources {
#     name   = "${each.value}"
#     cores         = var.vms_resources.vms_resource.vm_cores
#     memory        = var.vms_resources.vms_resource.vm_memory
#     core_fraction = var.vms_resources.vms_resource.vm_core_fraction
#   }

# #   resources {
# #     cores         = var.vms_resources.vms_resource.vm_cores
# #     memory        = var.vms_resources.vms_resource.vm_memory
# #     core_fraction = var.vms_resources.vms_resource.vm_core_fraction
# #   }

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
