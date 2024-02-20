FROM registry.access.redhat.com/ubi9/nginx-122

USER root

# Install Python and Pip
RUN dnf install -y python311 wget
RUN wget https://bootstrap.pypa.io/get-pip.py && python3 ./get-pip.py

# Initialize Devpi in /devpi folder
RUN pip install --quiet --upgrade devpi-server
RUN mkdir -p /devpi
RUN devpi-init --serverdir /devpi

# Allow root group to access devpi folder
RUN chgrp -R 0 /devpi && \
    chmod -R g+rwX /devpi

# Allow root group to access /etc/nginx/certs folder
RUN mkdir /etc/nginx/certs
RUN chgrp -R 0 /etc/nginx/certs && \
    chmod -R g+rwX /etc/nginx/certs

# Provide Nginx Devpi configuration in expected path
COPY nginx-devpi.conf "${NGINX_CONFIGURATION_PATH}"

USER 65532:0

COPY entrypoint.sh /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]
