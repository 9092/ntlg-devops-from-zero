resource "yandex_compute_disk" "extra_disks" {
  count = 3

  name = "disk-${count.index}"
  size = 1
}

resource "yandex_compute_instance" "storage_vm" {

  name = "storage"
  
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
  
  # Использование dynamic блока для подключения дополнительных дисков
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.extra_disks.*.id

    content {
      disk_id = secondary_disk.value
      mode    = "READ_WRITE"
    }
  }
}


