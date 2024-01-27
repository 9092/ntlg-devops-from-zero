
output "platform_outputs_map" {
  description = "outputs - platform"
  value = {
    web_vm_name = "${yandex_compute_instance.platform.name}"
    web_vm_fqdn = "${yandex_compute_instance.platform.fqdn}"
    web_vm_external_ip = "${yandex_compute_instance.platform.network_interface.0.nat_ip_address}"

    db_vm_name = "${yandex_compute_instance.platform_db.name}"
    db_vm_fqdn = "${yandex_compute_instance.platform_db.fqdn}"
    db_vm_external_ip = "${yandex_compute_instance.platform_db.network_interface.0.nat_ip_address}"
  }
}
