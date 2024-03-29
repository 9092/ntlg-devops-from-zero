# 02. Основы Git - Кулагин Игорь

**Ссылки на репозитории:**
- github: https://github.com/9092/devops-netology
- gitlab: https://gitlab.com/igor-kulagin/devops-netology

## Задание 1. Знакомимся с GitLab и Bitbucket
После регистрации в GitLab добавляем удаленные репозитории:

- По https:

`git remote add gitlab https://gitlab.com/igor-kulagin/devops-netology.git`

- По SSH (процесс генерации ключевой пары оставляем за скобками)

`git remote add gitlab-ssh git@gitlab.com:igor-kulagin/devops-netology.git`

`git remote add github-ssh git@github.com:9092/devops-netology.git`

- Результат:

![Task #1.01](screenshots/remote_repos.png) 


## Задание 2. Теги

**Создаем тэги:**

- простой

`git tag v0.0`

- аннотированный

`git tag -a v0.1 -m "annotated tag`

**Пушим тэги в репозитории**

`git push gitlab-ssh v0.0 v0.1`

`git push gitlab-ssh v0.0 v0.1`

**Результат:**

- github
![0.2 Task #2.01](screenshots/tags_github.png) 
- gitlab
![0.2 Task #2.02](screenshots/tags_gitlab.png)

## Задание 3. Ветки

> Переключитесь обратно на ветку main, которая должна быть связана с веткой main репозитория на github.

`git switch main`

> Посмотрите лог коммитов и найдите хеш коммита с названием Prepare to delete and move, который был создан в пределах предыдущего домашнего задания.

![0.2 Task #2.03](screenshots/0de25cf75adae567d32064a73771a257dcc8cf7c.png)

> Выполните git checkout по хешу найденного коммита.

`git checkout 0de25cf75adae567d32064a73771a257dcc8cf7c`

![0.2 Task #2.03](screenshots/checkout.png)

> Создайте новую ветку fix, базируясь на этом коммите `git switch -c fix`.
> Отправьте новую ветку в репозиторий на GitHub `git push -u origin fix`.
> Посмотрите, как визуально выглядит ваша схема коммитов:

![0.2 Task #2.04](screenshots/brach_graphical_view_1.png)

> Теперь измените содержание файла README.md, добавив новую строчку.

`echo "new line" >> README.md`

> Отправьте изменения в репозиторий и посмотрите, как изменится схема на странице https://github.com/YOUR_ACCOUNT/devops-netology/network и как изменится вывод команды git log.

```
echo "new line" >> README.md
git commit -a -m "updated README.md"
git push github-ssh
```
![0.2 Task #2.05](screenshots/brach_graphical_view_2.png)

![0.2 Task #2.05](screenshots/brach_pseudo_graphical_view.png)

## Задание 4. Упрощаем себе жизнь
>В используемой IDE PyCharm откройте визуальный редактор работы с Git, находящийся в меню View -> Tool Windows -> Git.

Я использую VSCode вместо PyCharm, но, думаю, это не принципиально. Плагины для работы с git в VSCode установлены и работают:

![0.2 Task #3.01](screenshots/vscode.png)




