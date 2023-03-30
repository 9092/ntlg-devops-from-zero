- Нагружаем 2 ядра CPU:

`for i in 1 2; do while : ; do : ; done & done`

- Снимаем нагрузку 

`for i in 1 2; do kill %$i; done`
