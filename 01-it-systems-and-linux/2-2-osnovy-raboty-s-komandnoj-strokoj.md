### 2.2. Основы работы с командной строкой [Кулагин Игорь]

## Задание 1
![2.2. Task #1 results](screenshots/2.2-1.png)
## Задание 2
```console
printf "Igor Kulagin\n"; printf "### $(date +%y-%m-%d)-lection-2.2 ###\n"; cat /etc/*-release
```
![2.2. Task #2 results](screenshots/2.2-2.png)
## Задание 3
![2.2. Task #3 results](screenshots/2.2-3.png)
## Задание 4
```console
mv ~/2.2.\ Igor\ Kulagin ~/2.2.\ Igor\ Kulagin\ $(date +%y-%m-%d); cd ~/2.2.\ Igor\ Kulagin\ $(date +%y-%m-%d); printf "Игорь Кулагин\n" > concept.1;printf "2.2. Основы работы с командной строкой\n" >> concept.1; cat /etc/*release >> concept.1; head -n 1 ./concept.1
```
![2.2. Task #4 results](screenshots/2.2-4.png)
## Задание 5
```console
sudo ln -s /home/ilk/2.2.\ Igor\ Kulagin\ 22-07-03/ /opt/ln_new_name
cp ~/2.2.\ Igor\ Kulagin\ 22-07-03/concept.1 /opt/ln_new_name/concept.1.old
rm 2.2.\ Igor\ Kulagin\ 22-07-03/concept.1
ls -alh ./2.2.\ Igor\ Kulagin\ 22-07-03/
````
![2.2. Task #4 results](screenshots/2.2-5.png)
## Задание 6
<details><summary>ЗАМЕЧАНИЕ К ДАННОМУ ЗАДАНИЮ</summary>
Ни в Debian/Ubuntu, ни тем более в Arch мне не удалось найти команды для менеджера пакетов, которые бы вернули список пакетов, установленных именно мной. Лучшее, что удалось сделать - это получить список пакетов, установленных вручную. Однако это не тоже самое, что установленные мной, конкретным пользователем, пакеты: эти пакеты мог установить любой другой пользователь системы, не обязательно именно я.
Хотелось бы узнать, что именно подразумевалось в задании и как предполагалось его решить. 
</details>

![2.2. Task #4 results](screenshots/2.2-6.1-ubuntu&debian.png)
![2.2. Task #4 results](screenshots/2.2-6.2-arch.png)
![2.2. Task #4 results](screenshots/2.2-6.3-arch.png)
## Задание 7
![2.2. Task #4 results](screenshots/2.2-7-arch.png)