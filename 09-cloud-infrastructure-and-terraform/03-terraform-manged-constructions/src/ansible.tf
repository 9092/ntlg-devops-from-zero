resource "local_file" "ansible_inventory" {
  content	= templatefile("${path.module}/ansible_hosts.tftpl",
    {	
	web 	=  yandex_compute_instance.web,
    	db 	=  yandex_compute_instance.db, 
    	storage =  [yandex_compute_instance.storage_vm]
    }  
)

  filename = "${abspath(path.module)}/hosts.cfg"
}

# Prepare and launch ansible playbook install_nginx.yml

resource "null_resource" "web_hosts_provision" {
  # Ждем создания инстанса
  depends_on = [yandex_compute_instance.web, local_file.ansible_inventory]
  
  # Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    command = "eval $(ssh-agent) && cat ~/.ssh/id_rsa | ssh-add -"
  }

  # Костыль!!! Даем ВМ 60 сек на первый запуск. Лучше выполнить это через wait_for port 22 на стороне ansible
  # В случае использования cloud-init может потребоваться еще больше времени
  provisioner "local-exec" {
    command = "sleep 60"
  }

  # Запуск ansible-playbook
  provisioner "local-exec" {                  
    #command = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/install_nginx.yml"
    command = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg -u ununtu --private-key /home/igor/.ssh/id_rsa ${abspath(path.module)}/install_nginx.yml"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }

# Срабатывание триггера при изменении переменных  
  triggers = {  
      
      # Всегда т.к. дата и время постоянно изменяются
      always_run         = "${timestamp()}" 
      
      # При изменении содержимого playbook файла
      playbook_src_hash  = file("${abspath(path.module)}/install_nginx.yml") 
      ssh_public_key     = var.ssh_root_public_key # при изменении переменной
    }
}
