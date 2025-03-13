FROM frappe/erpnext:v14.22.2

# Указываем пользователя root только для установки пакетов
USER root

WORKDIR /home/frappe

# Обновляем систему и устанавливаем Python
RUN apt-get update && apt-get install -y python3-pip python3-dev && \
    useradd -m frappe && \
    chown -R frappe:frappe /home/frappe

# Переключаемся на пользователя frappe перед установкой pip и bench
USER frappe

RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir frappe-bench && \
    bench setup requirements

CMD ["bench", "start"]
