# Создание образа базы данных
## Создаем исходный образ
Исходный образ будем создавать при помощи официального скрипта Oracle https://github.com/oracle/docker-images/tree/master/OracleDatabase/SingleInstance/dockerfiles

Запуск скрипта в моем случае выглядел так:
```
	./buildDockerImage.sh 18.4.0 -x
```

Для установки других версий, требуется самостоятельно сказать нужную версию СУБД.
Однако, большая часть версий больше недоступны для загрузки с официального сайта.
Важно убедиться, что ваша докермашина имеет достаточный объем RAM. Для данноей версии требуется более одного ГБ.

## Создаем образ с начальным скриптом
В папке `oracle` находится скрипт `startscript.sql`, который в нашем случае создает пользователя и таблицу.
Этот скрипт добавляется в образ, и будет запущен после старта бд.
Для сборки образа, находясь в внешней папке нужно ввести команду
```
	docker build -t mydb ./oracle/
```
где `mydb` имя нашего образа.
#Создание образа prometheus exporter
В качестве исходного образа будем использовать образ [iamseth/oracledb_exporter](https://github.com/iamseth/oracledb_exporter)
Для сборки образа нужно ввести команду
```
	docker build -t mydb_exporter ./oracle-exporter/
```
#Запуск контейнеров
Для запуска базы данных введем команду
```
	docker run -d -it -p 1521:1521 --name mydb mydb
```
Контейнер может запускаться несколько ~~десятков~~ минут.
Для запуска prometheus exporter используем команду
```
	docker run -d --name exporter --net=host migor33/oracle_exporter
```
`net=host` необходим, чтобы контейнер, стучась по адресу localhost:1521 попадал на контейнер с бд.
Доступ к prometheus exporter можно получить по адресу (ip докермашины):9161
#Подключаемся к базе через sqlplus
Подключиться к базе через созданного пользователя с помощью sqlplus, можно использовать команду
```
	sqlplus sus/mypassword@//(Адрес докермашины):1521/XEPDB1
```
##Демонстрация результата запроса
![Alt-текст](https://2.downloader.disk.yandex.ru/preview/a0253d2f90a2614052b0a6d2b28f0cbec51219aaa80cf6e51619a61eda894aa0/inf/wHvlsG38s4bJo2xzxaYCEExa04E4xqOdMQejAHv757kzX7g7c2Fc4sF4UzpI3oDsyOoCy4--7rhSBrtKMmJlEQ%3D%3D?uid=122767606&filename=Screenshot_6.png&disposition=inline&hash=&limit=0&content_type=image%2Fpng&owner_uid=122767606&tknv=v2&size=1903x937 "Орк")