- Нагружаем 2 ядра CPU:

`for i in 1 2; do while : ; do : ; done & done`

- Снимаем нагрузку 

`for i in 1 2; do kill %$i; done`

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
