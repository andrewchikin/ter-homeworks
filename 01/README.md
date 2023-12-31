# Домашнее задание к занятию «Введение в Terraform»

### Чек-лист готовности к домашнему заданию

1. Скачайте и установите актуальную версию **Terraform** >=1.4.X . Приложите скриншот вывода команды ```terraform --version```.
![задание 1](https://github.com/andrewchikin/ter-homeworks/blob/e21e1475937086f6b30d88a618c3e46a16c5ae4d/01/1.png)

### Задание 1

1. Перейдите в каталог [**src**](https://github.com/netology-code/ter-homeworks/tree/main/01/src). Скачайте все необходимые зависимости, использованные в проекте. 
2. Изучите файл **.gitignore**. В каком terraform-файле, согласно этому .gitignore, допустимо сохранить личную, секретную информацию?

# own secret vars store.
personal.auto.tfvars

3. Выполните код проекта. Найдите  в state-файле секретное содержимое созданного ресурса **random_password**, пришлите в качестве ответа конкретный ключ и его значение.
   "bcrypt_hash": "$2a$10$J2ik0sqgA81lc55OerIG9.Fd2oirDPzo2Dut.rntnyY3ejVi2/nqW",
    "id": "none",
    "result": "tJFowmnghA9g3ytK",

4. Раскомментируйте блок кода, примерно расположенный на строчках 29–42 файла **main.tf**.
Выполните команду ```terraform validate```. 
Success! The configuration is valid.
Объясните, в чём заключаются намеренно допущенные ошибки. Исправьте их.

Error: Missing name for resource
│ 
│   on main.tf line 24, in resource "docker_image":
│   24: resource "docker_image" {
│ 
должны объявить ресурс типа docker_image с именем nginx_image

╷
│ Error: Invalid resource name
│ 
│   on main.tf line 29, in resource "docker_container" "1nginx":
│   29: resource "docker_container" "1nginx" {
│ 
Название файла начинается на цифру, исправил на nginx

5. Выполните код. В качестве ответа приложите вывод команды ```docker ps```.
![задание 1](https://github.com/andrewchikin/ter-homeworks/blob/e21e1475937086f6b30d88a618c3e46a16c5ae4d/01/2.png)
6. Замените имя docker-контейнера в блоке кода на ```hello_world```. Не перепутайте имя контейнера и имя образа. Мы всё ещё продолжаем использовать name = "nginx:latest". Выполните команду ```terraform apply -auto-approve```.
Объясните своими словами, в чём может быть опасность применения ключа  ```-auto-approve```. В качестве ответа дополнительно приложите вывод команды ```docker ps```.
![задание 1](https://github.com/andrewchikin/ter-homeworks/blob/e21e1475937086f6b30d88a618c3e46a16c5ae4d/01/3.png)
```terraform apply -auto-approve``` - при использовании ключа apply выполняется сразу подтверждения.
8. Уничтожьте созданные ресурсы с помощью **terraform**. Убедитесь, что все ресурсы удалены. Приложите содержимое файла **terraform.tfstate**. 
terraform destroy
![задание 1](https://github.com/andrewchikin/ter-homeworks/blob/e21e1475937086f6b30d88a618c3e46a16c5ae4d/01/4.png)
9. Объясните, почему при этом не был удалён docker-образ **nginx:latest**. Ответ подкрепите выдержкой из документации [**провайдера docker**](https://docs.comcloud.xyz/providers/kreuzwerker/docker/latest/docs).

в ресурсе docker_image 
опционально доступны два параметра

keep_locally (Boolean) If true, then the Docker image won't be deleted on destroy operation. If this is false, it will delete the image from the docker local storage on destroy operation.
А здесь удаление происходит при команде терраформа destroy, чтобы удаление не произошло мы указали   keep_locally = false

force_remove (Boolean) If true, then the image is removed forcibly when the resource is destroyed.
Как я понял тут удаление происходит при удалении ресурса, как удалять именно ресурс(командой или просто из кода) мы либо не проходили, либо я пропустил. Буду благодарен, если объясните.


## Дополнительное задание (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.** Они помогут глубже разобраться в материале.   
Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 

### Задание 2*

1. Изучите в документации provider [**Virtualbox**](https://docs.comcloud.xyz/providers/shekeriev/virtualbox/latest/docs) от 
shekeriev.
2. Создайте с его помощью любую виртуальную машину. Чтобы не использовать VPN, советуем выбрать любой образ с расположением в GitHub из [**списка**](https://www.vagrantbox.es/).

В качестве ответа приложите plan для создаваемого ресурса и скриншот созданного в VB ресурса. 

------

### Правила приёма работы

Домашняя работа оформляется в отдельном GitHub-репозитории в файле README.md.   
Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 

