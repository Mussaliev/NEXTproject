FROM frappe/erpnext:v14.22.2

# Получаем root-доступ для установки системных пакетов
USER root
WORKDIR /home/frappe

# Обновляем apt и устанавливаем Python3, pip и необходимые библиотеки
RUN apt-get update && apt-get install -y python3-pip python3-dev && \
    chown -R frappe:frappe /home/frappe

# Переключаемся на пользователя frappe
USER frappe

# Обновляем pip и устанавливаем frappe-bench
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir frappe-bench

# Создаём рабочую директорию для bench и инициализируем bench в ней
RUN mkdir -p /home/frappe/frappe-bench && cd /home/frappe/frappe-bench && \
    bench init --frappe-branch version-14 --skip-redis-config-generation frappe-bench && \
    cd frappe-bench && \
    bench setup requirements

# Устанавливаем рабочую директорию
WORKDIR /home/frappe/frappe-bench

# Запускаем ERPNext
CMD ["bench", "start"]
