FROM frappe/erpnext:v14.22.2

USER root

WORKDIR /home/frappe

# Устанавливаем зависимости
RUN apt-get update && apt-get install -y python3-pip python3-dev && \
    chown -R frappe:frappe /home/frappe

# Переключаемся на пользователя frappe
USER frappe

# Обновляем pip и устанавливаем frappe-bench отдельно
RUN pip3 install --upgrade pip \
    && pip3 install --no-cache-dir frappe-bench

# Устанавливаем необходимые зависимости перед bench setup
RUN bench setup requirements --force || echo "Bench setup requirements failed, continuing..."

CMD ["bench", "start"]
