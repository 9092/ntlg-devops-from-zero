# 05.3. Введение. Экосистема. Архитектура. Жизненный цикл Docker-контейнера - Кулагин Игорь
## Задача 1.

<details>
<summary> Вспомогательные команды для Ubuntu</summary>
Создаем каталог Docker:
```
mkdir ~/docker
```
В этой папке создаем файл с именем Docker со следующим содержимым:
```
FROM nginx:latest
EXPOSE 80
COPY index.html  /usr/share/nginx/html/
```
Создаем в той же директории файл index.html следующего содержания:
```
<html>
 <head>
  <meta charset="UTF-8">
  Hey, Netology
 </head>
 <body>
  <h1>I'm DevOps Engineer!</h1>
 </body>
</html>
```
Строим образ Docker:
```
sudo docker build -t ilkul-nginx-image .
```
Создаем и запускаем контейнер:
```
sudo docker run -d -p 80:80 <имя_образа>
# Имя образа можно посмотреть командой docker image ls
```
В браузере пробуем открыть index.html, набрав в адресной строке http://127.0.0.1 

Проверяем версию nginx:
```
sudo docker exec -it <имя_контейнера> /bin/bash
# Имя контейнера можно посмотреть командой docker container ls -a

nginx -v
```
Останавливаем контейнер:
```
docker stop <имя_контейнера>
```
Тэгируем контейнер и указываем удаленный репозиторий:
```
sudo docker tag <имя_исходного_образа>:<его_тэг> <имя_пользователя_docker_hub>/<имя_образа_в_docker_hub>:<тэг_образа_в_docker_hub>
```
Логинимся в docker hub:
```
sudo chmod 666 /var/run/docker.sock

# Без этого в Ubuntu будет ошибка
https://newbedev.com/got-permission-denied-while-trying-to-connect-to-the-docker-daemon-socket-at-unix-var-run-docker-sock-post-http-2fvar-2frun-2fdocker-sock-v1-24-auth-dial-unix-var-run-docker-sock-connect-permission-denied-code-example
docker login -u <username>

# В качестве пароля используется токен, который нужно создать в разделе Account settings/Security в Docker Hub
```
Заливаем образ в репозиторий:
```
docker push <your-dockerhub-username>/<image-name>:<image-tag>
```
</details>

> Опубликуйте созданный fork в своём репозитории и предоставьте ответ в виде ссылки на 
```
docker pull ikul/ikul-nginx:1.25.3
```
https://hub.docker.com/repository/docker/ikul/ikul-nginx/general

## Задача 2


## Задача 3
> Запустите первый контейнер из образа centos c любым тегом в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера.
```
docker pull centos:latest
sudo docker run -td -v ~/study/docker/data:/data --name centos centos
```

> Запустите второй контейнер из образа debian в фоновом режиме, подключив папку /data из текущей рабочей директории на хостовой машине в /data контейнера.
```
docker pull debian:latest
sudo docker run -td -v ~/study/docker/data:/data --name debian debian
```

> Подключитесь к первому контейнеру с помощью docker exec и создайте текстовый файл любого содержания в /data.

```
docker exec -it centos /bin/bash
echo "Look, Mom, I'm devops!" >> /data/message_to_mom.txt
```

> Добавьте ещё один файл в папку /data на хостовой машине.
```
sudo touch ~/study/docker/data/just_another_file.txt
```
> Подключитесь во второй контейнер и отобразите листинг и содержание файлов в /data контейнера.
```
docker exec -it debian /bin/bash
ls /data
```
![Task #5.3-3](screenshots/5.3-3.png)