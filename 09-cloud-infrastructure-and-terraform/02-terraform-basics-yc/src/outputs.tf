output "platform_outputs_map" {
  description = "outputs - platform"
  value = {
    vm_name = "${yandex_compute_instance.platform.name}"
    vm_fqdn = "${yandex_compute_instance.platform.fqdn}"
    vm_external_ip = "${yandex_compute_instance.platform.network_interface.0.nat_ip_address}"
  }
}

output "platform_db_outputs_map" {
  description = "outputs - platform_db"
  value = {
    vm_name = "${yandex_compute_instance.platform_db.name}"
    vm_fqdn = "${yandex_compute_instance.platform_db.fqdn}"
    vm_external_ip = "${yandex_compute_instance.platform_db.network_interface.0.nat_ip_address}"
  }
}
