# Развертывание инфраструктуры

1. Склонируйте репозиторий

```
git clone https://github.com/EkaterinaNikolaeva/hse-cloud-technologies.git
```

2. Перейдите в директорию задания

```
cd task-3/
```

3. Задайте необходимые переменные окружения

```
export TF_VAR_token=$(yc iam create-token)
export TF_VAR_db_pass="<your future password>"
export TF_VAR_folder_id=$(yc config get folder-id)
export TF_VAR_cloud_id=$(yc config get cloud-id)
```

4. Запустите инициализацию terraform-окружения

```
terraform init
```

5. Для составления плана применения выполните

```
terraform plan
```

6. Для создания ресурсов выполните

```
terraform apply
```

## Описание

В модулях (`/modules`) описывается описание сборки отдельных компонентов: базы данных (`/modules/db`), сети и подсети (`/modules/network`), вычислительного ресурсы (`/modules/compute`), сервисного аккаунта (`/modules/iam`), объектного хранилища (`/modules/object_storage`).

В `variables.tf` описываются переменные, необходимые для выполнения развертывания инфраструктуры. Значение переменных можно задать в переменных окружения или файле `terraform.tfvars`. `main.tf` описывает сборку всех компонентов воедино с заданием специфичных для конкретной компоненты переменных.
