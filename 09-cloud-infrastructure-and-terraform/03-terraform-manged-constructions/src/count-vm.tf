data "yandex_compute_image" "ubuntu" {
  family = var.vm_image_name
}

resource "yandex_compute_instance" "web" {
  count		= 2
  
  name		= "web-${count.index + 1}"
  platform_id   = var.platform_id

  resources {
    cores         = var.vm_web_cores
    memory        = var.vm_web_memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size = var.boot_disk_size
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    security_group_ids = [yandex_vpc_security_group.example.id]
    nat       = true
  }

  metadata = {
    serial-port-enable = var.serial_port_state 
    ssh-keys           = "ubuntu:${file(local.ssh_key_path)}"
  }
 
  depends_on = [
    yandex_compute_instance.db["main"],
    yandex_compute_instance.db["replica"]
  ]
}
