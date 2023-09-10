//Объявите в файле outputs.tf output типа map, содержащий { instance_name = external_ip } для каждой из ВМ.
//2. Примените изменения.

# output "output_web" {
#     type = map(string)
#     value = { 
#         "instance_name" = "external_ip"
#         }
#     description = "network_interface"
# }

output "output_network_interface" {
    value = { 
        "network_interface_platform_web" = yandex_compute_instance.platform_web.network_interface[0].nat_ip_address,
        "network_interface_platform_db" = yandex_compute_instance.platform_db.network_interface[0].nat_ip_address
        }
    description = "network_interface"

}


# output "output_network_interface" {
#     value = yandex_compute_instance.platform_web.network_interface[0].nat_ip_address
#     description = "network_interface"
# }
