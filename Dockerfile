FROM frappe/erpnext:v14.22.2

USER root

WORKDIR /home/frappe

# Обновляем систему и устанавливаем Python, но не запускаем pip от root
RUN apt-get update && apt-get install -y python3-pip python3-dev && \
    useradd -m frappe && \
    chown -R frappe:frappe /home/frappe && \
    su frappe -c "pip3 install --upgrade pip && pip3 install --no-cache-dir frappe-bench && bench setup requirements"

USER frappe

CMD ["bench", "start"]
