###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
  sensitive   = true
}

variable "cloud_id" {
  type        = string
  default     = "b1get9r87fbg41m2mrgu"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  default     = "b1g90asbm64881hb6q3p"
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
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
  description = "VPC network & subnet name"
}

###ssh vars

variable "vms_ssh_root_key" {
  type        = string
  description = "ssh-keygen -t ed25519"
}

variable "vm_web_compute_map" {
  type    = map(number)
  default = {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }
}

variable "proj" {
  type         = string
  description   = "interpolation: project"
}

variable "env" {
  type         = string
  description   = "interpolation: environment"
}

variable "app" {
  type         = string
  description   = "interpolation: app"
}

variable "vm_web_image_name" {
  type         = string
  default       = "ubuntu-2004-lts"
  description   = "vm web image name"
}

variable "vm_web_platform_name" {
  type          = string
  default       = "standard-v1"
  description   = "wm web platform id at yc"
}

#variable "vm_web_compute_instance_name" {
#  type          = string
#  default       = "netology-develop-platform-web"
#  description   = "vm web compute instance name"
#}

