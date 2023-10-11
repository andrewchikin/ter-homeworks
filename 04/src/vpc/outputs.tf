output network_id {
  value       = yandex_vpc_network.develop.id
  sensitive   = false
  description = "id of network"
}

output "subnet_id" {
  value       = yandex_vpc_subnet.develop.id
  description = "id of subnet"

}