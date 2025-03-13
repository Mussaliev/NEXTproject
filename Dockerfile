FROM frappe/erpnext:v14.22.2

USER root

WORKDIR /home/frappe

# Устанавливаем зависимости
RUN apt-get update && apt-get install -y python3-pip python3-dev && \
    chown -R frappe:frappe /home/frappe

# Переключаемся на пользователя frappe
USER frappe

# Обновляем pip и устанавливаем frappe-bench
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir frappe-bench

# Создаём директорию frappe-bench и выполняем setup
RUN mkdir -p /home/frappe/frappe-bench && cd /home/frappe/frappe-bench && \
    bench init --skip-redis-config-generation && \
    bench setup requirements

WORKDIR /home/frappe/frappe-bench

CMD ["bench", "start"]
