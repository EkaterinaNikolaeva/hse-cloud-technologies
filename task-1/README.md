# Автоматизизация создания образа виртуальной машины с приложением и необходимыми сервисами, используя инструменты Packer и Ansible

## Сборка образа

1. Склонируйте репозиторий

```
git clone https://github.com/EkaterinaNikolaeva/hse-cloud-technologies.git
```

2. Перейдите в директорию задания

```
cd task-1/
```

3. Задайте необходимые переменные окружения

```
export YC_FOLDER_ID=<folder_id>
export YC_SUBNET_ID=<subnet_id>
export YC_TOKEN=$(yc iam create-token)
```

4. Запустите инициализацию Packer-конфигурации

```
packer init packer/config.pkr.hcl
```

4*. Для валидации Packer-конфигурации запустите

```
packer validate packer/config.pkr.hcl
```

5. Для сборки образа виртуальной машины запустите

```
packer build packer/config.pkr.hcl
```
