resource "yandex_compute_instance" "db" {
  for_each	= var.each_vm

  name		= each.key

  resources {
    cores	= each.value.cpu
    memory	= each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id	= data.yandex_compute_image.ubuntu.image_id
      size	= each.value.disk_volume
    }
  }

  network_interface {
     subnet_id	= yandex_vpc_subnet.develop.id
     security_group_ids = [yandex_vpc_security_group.example.id]
     nat	= true
  }

  metadata = {
     serial-port-enable	= var.serial_port_state
     ssh-keys		= "ubuntu:${file(local.ssh_key_path)}"
  }
}

