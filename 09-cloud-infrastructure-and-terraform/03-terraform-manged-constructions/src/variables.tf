###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "ssh_root_public_key" {
  type        = string
  description = "ssh-keygen -t ed25519"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "platform_id" {
  type        = string
  default     = "standard-v1"
  description = "platform id at yc"
}

variable "core_fraction" {
  type        = number
  default     = 5
  description = "vm core fraction"
}

variable "vm_image_name" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "vm image name"
}

variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "default web vm cpu"
}

variable "vm_web_memory" {
  type        = number
  default     = 2
  description = "default web vm mem"
}

variable "boot_disk_size" {
  type        = number
  default     = 10
  description = "default boot disk size"
}

variable "serial_port_state" {
  type        = number
  default     = 1
  description = "serial port state: 1- enabled, 0 - disabled"
}

variable "each_vm" {
  description = "Specifications for each VM"
  type = map(object({
    cpu = number
    ram = number
    disk_volume = number
  }))
}

