# Kittygram

## Проверка проекта

Результат с работой можно посмотреть в артефактах github. Туда отправляется сгеренированный test.yml, с полученным при развертывании инфры ip. Также можно посмотреть его в UI гитхаб после завершения джобы Kittygram Deploy в Autotests summary.

## Структура репозитория

```
.
+-- backend/                  # Django REST API
|   +-- Dockerfile            # python:3.9-slim + gunicorn
|   +-- requirements.txt      # зависимости Python
|   +-- kittygram_backend/    # настройки Django
|   +-- cats/                 # приложение с моделями
|   +-- manage.py
+-- frontend/                 # React SPA
|   +-- Dockerfile            # node:18 + npm build
|   +-- package.json
|   +-- src/                  # исходный код React
+-- nginx/                    # Gateway
|   +-- Dockerfile            # nginx:1.22.1
|   +-- nginx.conf            # конфигурация reverse proxy
+-- infra/                   # Terraform (Yandex Cloud)
|   +-- main.tf               # вызов модулей: network, security, compute
|   +-- provider.tf           # Yandex provider + S3 backend для state
|   +-- variables.tf          # переменные (VM, сеть, зона)
|   +-- data.tf               # Yandex Lockbox (SSH-ключ)
|   +-- outputs.tf            # vm_public_ip, vm_username
|   +-- modules/
|       +-- compute/          # создание VM + cloud-init
|       +-- network/          # VPC + подсети
|       +-- security/         # SG: SSH(22), HTTP(80)
+-- deploy/
|   +-- ansible/              # Ansible плейбуки
|   |   +-- provision.yml     # подготовка сервера (role: common)
|   |   +-- deploy.yml        # деплой приложения
|   |   +-- all.yml           # объединяет provision + deploy
|   |   +-- inventory/hosts.yml  # динамический инвентори
|   |   +-- templates/env.j2  # шаблон .env
|   |   +-- roles/common/tasks/main.yml  # apt-пакеты, директория
|   +-- kittygram/
|       +-- docker-compose.yml  # Docker Compose для деплоя
+-- docker-compose.production.yml  # production compose (БЕЗ build -- только image)
+-- tests/                    # автотесты (pytest)
|   +-- conftest.py           # фикстуры
|   +-- test_files.py         # проверка файлов репозитория
|   +-- test_dockerhub_images.py  # проверка образов DockerHub
|   +-- test_connection.py    # проверка доступности сайта
+-- tests.yml                 # конфиг для автотестов
+-- kittygram_workflow.yml    # копия .github/workflows/deploy.yml
+-- terraform_workflow.yml    # копия .github/workflows/infra.yml
+-- _env.example              # пример .env файла
+-- pytest.ini                # настройки pytest
+-- setup.cfg                 # настройки flake8
```

## Воркфлоу

Проект использует два независимых пайплайна, один ответсвенный за развертывание инфры, другой за деплой на только что созданный сервер. Для отправки уведомлений используется локальный композит экшн.
