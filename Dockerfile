FROM frappe/erpnext:v14.22.2

USER root

WORKDIR /home/frappe

# Исправление ошибки apt-get update
RUN mkdir -p /var/lib/apt/lists/partial && \
    apt-get update && \
    apt-get install -y python3-pip python3-dev && \
    pip3 install --upgrade pip && \
    pip3 install --no-cache-dir frappe-bench && \
    bench setup requirements

USER frappe

CMD ["bench", "start"]
