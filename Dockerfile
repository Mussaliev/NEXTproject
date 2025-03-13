FROM frappe/erpnext:v14.22.2

USER root

WORKDIR /home/frappe

# Обновляем систему и устанавливаем Python
RUN apt-get update && apt-get install -y python3-pip python3-dev && \
    chown -R frappe:frappe /home/frappe

# Переключаемся на пользователя frappe
USER frappe

RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir frappe-bench && \
    bench setup requirements

CMD ["bench", "start"]
