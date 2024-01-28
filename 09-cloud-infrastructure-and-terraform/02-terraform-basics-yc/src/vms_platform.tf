### db vm variables

variable "vm_db_zone" {
  type        = string
  default     = "ru-central1-b"
  description = "db vm zone"
}

variable "vm_db_compute_resources_map" {
  type    = map(number)
  default = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
}

variable "vm_db_image_name" {
  type         = string
  default       = "ubuntu-2004-lts"
  description   = "vm web image name"
}

variable "vm_db_platform_name" {
  type          = string
  default       = "standard-v1"
  description   = "wm web platform id at yc"
}

#variable "vm_db_compute_instance_name" {
#  type          = string
#  default       = "netology-develop-platform-db"
#  description   = "vm web compute instance name"
#}

variable "vm_db_subnet" {
  type          = list(string)
  default       = ["10.0.10.0/24"]
  description   = "subnet for vm db"
}

variable "vm_db_subnet_name" {
  type          = string
  default       = "platform_db_subnet"
  description   = "subnet for vm db"
}

### create a subnet in new zone

resource "yandex_vpc_subnet" "platform_db" {
  name           = var.vm_db_subnet_name
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.vm_db_subnet
}

### db compute node instance declaration

resource "yandex_compute_instance" "platform_db" {
  name        	  = local.db_vm_name
  zone	      	  = var.vm_db_zone
  platform_id 	  = var.vm_db_platform_name
  resources {
    cores         = var.vm_db_compute_resources_map.cores
    memory        = var.vm_db_compute_resources_map.memory
    core_fraction = var.vm_db_compute_resources_map.core_fraction
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
    subnet_id = yandex_vpc_subnet.platform_db.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "ubuntu:${var.vms_ssh_root_key}"
  }

}

