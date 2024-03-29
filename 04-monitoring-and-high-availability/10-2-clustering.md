# 10.2. Кластеризация - Кулагин Игорь
## Задание 1

>В чём различие между SMP- и MPP-системами?

SMP-системы - это системы с несколькими процессорами, которые используют общую память и обмениваются данными через общую шину. MPP-системы - это системы с множеством процессоров, каждый из которых имеет собственную память и обрабатывает свой сегмент данных.

## Задание 2
>В чём отличие сильно связанных и слабо связанных систем?

Сильно связанные системы - компоненты жестко связаны, быстро обмениваются данными и изменения в одном компоненте сильно влияют на другие.

Слабо связанные системы - компоненты не зависят друг от друга и могут работать независимо. Обмен данными и сигналами медленнее, изменения в одном компоненте не оказывают сильного влияния на другие.

Отличие между ними - насколько жестко компоненты связаны и насколько они зависят друг от друга для выполнения функций.

## Задание 3
>Какие преимущества отличают кластерные системы от обычных серверов?

Кластерные системы объединяют вычислительные ресурсы нескольких серверов, что позволяет увеличить производительность системы в целом благодаря распределению нагрузки. Они также обладают высокой отказоустойчивостью, легко масштабируются и могут быть экономически выгоднее для использования благодаря более эффективному использованию вычислительных ресурсов. Кроме того, управление кластерными системами может быть более удобным благодаря единому интерфейсу управления.

## Задание 4
>Приведите примеры типов современных кластерных систем.

- **Кластеры высокой доступности (HA)** - используется везде, где требуется высокая доступность приложений или сервисов. Такой кластер состоит из двух или более узлов, которые работают в режиме активного и резервного узла. Если один узел выходит из строя, другой узел автоматически перенимает работу и продолжает обслуживать пользователей. Кластера такого типа применяются при построении  отказоустойчивые базы данных, веб-серверы, приложения для электронной коммерции и т.п.
- **Кластеры с балансировкой нагрузки (NLB)** - тип вычислительных кластеров, который распределяет нагрузку между несколькими узлами. Такие типы кластеров также могут использовать для построения веб-сервисов, СУБД и любых других сервисов или приложений с высокой нагрузкой, которую нужно разносить на разные ноды кластера.
- **Кластеры высокой производительности (HPC)** - используются для высокопроизводительных вычислений как правило в научных и исследовательских областях. Такой кластер обычно состоит из нескольких узлов, которые работают в режиме параллельных вычислений, чтобы обеспечить максимальную производительность и скорость обработки данных. Примеры использования кластеров высокой производительности: научные исследования, анализ больших данных, расчеты в инженерии.
- **Системы распределенных вычислений** - это тип вычислительных систем, которые объединяют множество компьютеров или узлов, работающих вместе как единая система. Системы распределенных вычислений обычно используются для обработки больших объемов данных, которые могут быть разделены на множество более мелких задач и выполнены параллельно на разных узлах системы. Как правило используются для вычисления научных моделей, параллельной обработки данных, машинного обучение и искусственного интеллекта.

## Задание 5
>Где используют сервис Kafka, rabitMQ?

Kafka и RabbitMQ — это системы управления очередями сообщений. Обе системы широко используются для асинхронной передачи сообщений между приложениями, однако Kafka лучше подходит для обработки больших объемов потоков данных в реальном времени, тогда как RabbitMQ оптимизирован для надежной доставки сообщений и обработки сложных сценариев маршрутизации.

RabbitMQ обычно используется для управления очередями сообщений между сервисами в приложениях с микросервисной архитектурой, для которых важны возможность настройки сложных правил маршрутизации и надежность доставки сообщений.

Kafka наиболее часто используется для агрегирования журналов и аналитики в реальном времени, и в случаях, когда предъявляются высокие требования к объему передаваемых данных. Kafka более сложна в настройке и поддержке по сравнению с RabbitMQ, потому больше подходит для организаций с крупномасштабными потребностями в распределенной обработке данных.



