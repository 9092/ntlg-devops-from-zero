### 4.9. DHCP, PXE [Кулагин Игорь]
**Задание 1.**
>Для чего служит протокол DHCP?

Для автоматического конфигурирования некоторых сетевых опций на хостах локальной сети.

>Может ли работать сеть без DHCP-сервера?

Да, может. Все настройки можно сделать вручную. Также частично задачу автоматического конфигурирования IP-адресов для хостов в локальной сети может решить протокол APIPA.

**Задание 2.**
>На каком порту/портах работает DHCP?

67,68/UDP

**Задание 3.**
>Какие настройки можно произвести используя опции?
>Назовите 5

- option 1: subnet mask
- option 2: default gateway
- option 6: DNS settings
- option 15: domain name suffix
- option 42: NTP servers list

**Задание 4.**
>Сконфигурируйте сервер DHCP.
>Пришлите получившийся конфигурационный файл.

```
option domain-name "netology.lab";
option domain-name-servers 1.1.1.1, 8.8.8.8;

default-lease-time 600;
max-lease-time 7200;

ddns-update-style none;

authoritative;

subnet 10.5.5.0 netmask 255.255.255.0 {
  range 10.5.5.10 10.5.5.100;
  option domain-name-servers 1.1.1.1;
  option domain-name "netology.lab";
  option subnet-mask 255.255.255.0;
  option routers 10.5.5.1;
  option broadcast-address 10.5.5.255;
  default-lease-time 600;
  max-lease-time 7200;
}
```