- Нагружаем 2 ядра CPU:

`for i in 1 2; do while : ; do : ; done & done`

- Снимаем нагрузку 

`for i in 1 2; do kill %$i; done`


`journalctl -xeu keepalived`

# 9.4 Установка Prometheus
```
sudo groupadd --system prometheus
sudo useradd --no-create-home --shell /sbin/nologin --system -g prometheus prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
```
```
wget https://github.com/prometheus/prometheus/releases/download/v2.43.0/prometheus-2.43.0.linux-amd64.tar.gz
tar xvfz prometheus-*.tar.gz
cd prometheus-*
sudo cp prometheus promtool /usr/local/bin/
sudo cp prometheus.yml /etc/prometheus/prometheus.yml
sudo cp -R consoles/ console_libraries/ /etc/prometheus/
sudo chown -R prometheus:prometheus /etc/prometheus /var/lib/prometheus
sudo chown -R prometheus:prometheus /usr/local/bin/prometheus
sudo chown prometheus:prometheus /usr/local/bin/promtool
```
```
/usr/local/bin/prometheus \
--config.file /etc/prometheus/prometheus.yml \
--storage.tsdb.path /var/lib/prometheus/ \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries
```

```
nano /etc/systemd/system/prometheus.service
```

```
[Unit]
Description=Prometheus Service Netology Lesson 9.4
After=network.target
[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
--config.file /etc/prometheus/prometheus.yml \
--storage.tsdb.path /var/lib/prometheus/ \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries
ExecReload=/bin/kill -HUP $MAINPID Restart=on-failure
[Install]
WantedBy=multi-user.target
```

`sudo chown -R prometheus:prometheus /var/lib/prometheus`

`sudo systemctl enable prometheus`

`sudo systemctl start prometheus`

`sudo systemctl status prometheus`

# 9.4 установка Node exporter
```
wget https://github.com/prometheus/node_exporter/releases/download/v1.5.0/node_exporter-1.5.0.linux-amd64.tar.gz
tar xvfz node_exporter-*.*-amd64.tar.gz
cd node_exporter-*.*-amd64
./node_exporter
```
`sudo mkdir -p /etc/prometheus/node-exporter && sudo cp ./* /etc/prometheus/node-exporter`
`sudo nano /etc/systemd/system/node-exporter.service`
```
[Unit]
Description=Node Exporter Lesson 9.4
After=network.target
[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/etc/prometheus/node-exporter/node_exporter
[Install]
WantedBy=multi-user.target
```
`sudo systemctl enable node-exporter`
`sudo systemctl start node-exporter`
`sudo systemctl status node-exporter`

`sudo nano /etc/prometheus/prometheus.yml`
```
   scrape_interval: 5s
   static_configs:
     - targets: ["localhost:9090"]
     - targets: ["192.168.10.14:9100"]
     - targets: ["192.168.10.17:9100"]
```
`sudo systemctl restart prometheus`

#9.4 Установка Grafana
```
sudo apt-get install -y adduser libfontconfig1
wget https://dl.grafana.com/oss/release/grafana_9.4.7_amd64.deb
sudo dpkg -i grafana_9.4.7_amd64.deb
```
```
sudo systemctl enable grafana-server && \
sudo systemctl start grafana-server && \ 
sudo systemctl status grafana-server
```

http://<наш сервер>:3000 (admin \ admin)


# 9.5 установка Node exporter
> Создайте файл с правилом оповещения, как в лекции, и добавьте его в конфиг Prometheus.
`sudo nano /etc/prometheus/netology-test.yml`

```
groups: # Список групп
- name: netology-test # Имя группы
  rules: # Список правил текущей группы
  - alert: InstanceDown # Название текущего правила
    expr: up == 0 # Логическое выражение
    for: 1m # Сколько ждать отбоя предупреждения перед отправкой оповещения
    labels:
      severity: critical # Критичность события
    annotations: # Описание
      description: '{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minute.' # Полное описание алерта
      summary: Instance {{ $labels.instance }} is down # Краткое описание алерта
```
`sudo nano /etc/prometheus/prometheus.yml`

*Добавьте в раздел **rule_files запись**:* `- "netology-test.yml"`
`sudo systemctl restart prometheus && sudo systemctl status prometheus`

`sudo nano /etc/prometheus/alertmanager.yml`
```
global:
route:
 group_by: ['alertname'] # Параметр группировки оповещений - по имени
 group_wait: 30s # Сколько ждать восстановления, перед тем как отправить первое оповещение.
 group_interval: 10m # Сколько ждать перед тем как дослать оповещение о новых сработках по текущему алерту.
 repeat_interval: 60m # Сколько ждать перед тем как отправить повторное оповещение
 receiver: 'email' # Способ которым будет доставляться текущее оповещение
receivers: # Настройка способов оповещения
- name: 'email'
  email_configs:
  - to: 'yourmailto@todomain.com'
    from: 'yourmailfrom@fromdomain.com'
    smarthost: 'mailserver:25'
    auth_username: 'user'
    auth_identity: 'user'
    auth_password: 'paS$w0rd'
```

`sudo systemctl restart prometheus-alertmanager && systemctl status prometheus-alertmanager`


## Задание 2
>Установите Alertmanager и интегрируйте его с Prometheus.
```
wget https://github.com/prometheus/alertmanager/releases/download/v0.24.0/alertmanager-0.24.0.linux-amd64.tar.gz
tar -xvf alertmanager-0.24.0.linux-amd64.tar.gz
```
```
sudo cp ./alertmanager-*.linux-amd64/alertmanager /usr/local/bin
sudo cp ./alertmanager-*.linux-amd64/amtool /usr/local/bin
```
```
sudo cp ./alertmanager-*.linux-amd64/alertmanager.yml /etc/prometheus
sudo chown -R prometheus:prometheus /etc/prometheus/alertmanager.yml
```
`sudo nano /etc/systemd/system/prometheus-alertmanager.service`
```
[Unit]
Description=Alertmanager Service
After=network.target
[Service]
EnvironmentFile=-/etc/default/alertmanager
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/alertmanager \
--config.file=/etc/prometheus/alertmanager.yml \
--storage.path=/var/lib/prometheus/alertmanager $ARGS
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure
[Install]
WantedBy=multi-user.target
```
```
sudo systemctl enable prometheus-alertmanager
sudo systemctl start prometheus-alertmanager
sudo systemctl status prometheus-alertmanager
```

`sudo nano /etc/prometheus/prometheus.yml`
```
alerting:
 alertmanagers:
 - static_configs:
 - targets: # Можно указать как targets: [‘localhost”9093’]
 - localhost:9093 
```

## Задание 3
>Активируйте экспортёр метрик в Docker и подключите его к Prometheus.

```
sudo apt update
sudo apt-get install ca-certificates curl gnupg -y
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```
```
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo docker run hello-world
```
```
sudo nano /etc/docker/daemon.json
```
```
{
 "metrics-addr" : "0.0.0.0:9323",
 "experimental" : true
}
```
`sudo systemctl restart docker && systemctl status docker`

`sudo nano /etc/prometheus/prometheus.yml`

```
 static_configs:
      - targets: ["localhost:9090"]
      - targets: ["192.168.10.14:9100"]
      - targets: ["192.168.10.17:9100"]
      - targets: ["localhost:9323"]
```
`sudo systemctl restart prometheus && systemctl status prometheus`

## Задание 4
`docker pull zabbix/zabbix-appliance`




# 10.1
Keepalived

`sudo apt install keepalived -y`
`sudo nano /etc/keepalived/keepalived.conf`

```
vrrp_instance VI_1 {
    state BACKUP
    interface eth0
    virtual_router_id 51
    priority 100
    advert_int 1
    authentication {
        auth_type PASS
        auth_pass 123456
    }

    unicast_peer {
        172.29.200.100
}


    virtual_ipaddress {
        192.29.224.10/24
}
```

