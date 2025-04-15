# SSH Keys Recovery

Репозиторий для хранения SSH ключей и скриптов восстановления.

## Восстановление доступа

### Метод 1: Использование curl (рекомендуется)

```bash
# Выполните в режиме восстановления:
curl -s https://raw.githubusercontent.com/nohavewho/ssh-keys-recovery/main/recovery-script.sh | bash
```

### Метод 2: Ручное добавление ключа

```bash
# Создайте директорию .ssh
mkdir -p /mnt/root/.ssh

# Скачайте ключ
curl -s https://raw.githubusercontent.com/nohavewho/ssh-keys-recovery/main/v.yushenko.pub > /mnt/root/.ssh/authorized_keys

# Установите правильные права
chmod 700 /mnt/root/.ssh
chmod 600 /mnt/root/.ssh/authorized_keys
```

## Исправление проблем с nginx

```bash
# После восстановления доступа и перезагрузки сервера
curl -s https://raw.githubusercontent.com/nohavewho/ssh-keys-recovery/main/fix-nginx.sh | bash
```