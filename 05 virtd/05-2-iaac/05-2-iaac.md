# 05.1. ВПрименение принципов IaaC в работе с виртуальными машинами - Кулагин Игорь
### Задача 1
> Опишите основные преимущества применения на практике IaaC-паттернов.
1. Существенное ускорение развертывания инфраструктуры за счет повторяемости однажды выполненных действий по конфигурации.
2. Позволяет легко устранить дрейф конфигурации везде, где это нужно. Например,  между различными средами PREPROD и PROD.
3. Общее ускорение выполнения рутинных задач, что в результате ведет к снижению параметра `Time To Market` - одного из ключевых показателей в современном мире цифровых решений.

> Какой из принципов IaaC является основополагающим?

**Идемпотентность** - свойство операции, гарантирующее получение идентичного результата при ее многократном выполнении.

### Задача 2
> Чем Ansible выгодно отличается от других систем управление конфигурациями?

1. Низкий порог входа по сравнению с другими системами управления конфигураций.
2. Написана на Python, одном из самых популярных и простых языков программирования, что позволяет относительно просто дописывать свои модули, а также использовать большое количество уже существующих, расширяя функциональность решения.
3. Более высокая популярность системы по сравнению с аналогами, что позволяет легче найти ответы на возникающие при эксплуатации вопросы и экспертизу на рынке.
4. Не требует установки агентов не целевые хосты.

> Какой, на ваш взгляд, метод работы систем конфигурации более надёжный — push или pull?

Полагаю, что `pull` так как в этом случае точка отказа только сама система управления конфигурациями, ведь хосты будут обращаться к серверу конфигураций только если с ними все в порядке. В случае же `push`-подхода конфигурация может "не доехать" до хоста еще и из-за недоступности самого хоста, на который нужно применить конфигурацию.

### Задача 3
> Установите на личный linux-компьютер(или учебную ВМ с linux):
> VirtualBox, Vagrant версии 2.3.4, Terraform версии 1.5.Х, Ansible.

> Приложите вывод команд установленных версий каждой из программ, оформленный в Markdown.

```
vagrant --version
Vagrant 2.3.4
```
---
```
terraform --version
Terraform v1.5.7
on linux_amd64

Your version of Terraform is out of date! The latest version
is 1.6.4. You can update by downloading from https://www.terraform.io/downloads.html
```
---
```
ansible --version
ansible 2.10.8
  config file = None
  configured module search path = ['/home/igor/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.10.12 (main, Jun 11 2023, 05:26:28) [GCC 11.4.0]
```
---
```
vboxmanage --version
6.1.38_Ubuntur153438
```
![Task #5.2-3](screenshots/5.2-3.png) 

### Задача 4
![Task #5.2-4.1](screenshots/5.2-4.1.png)
![Task #5.2-4.2](screenshots/5.2-4.2.png)
![Task #5.2-4.3](screenshots/5.2-4.3.png)