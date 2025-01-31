FROM alpine:3.18.5

LABEL maintainer="Michael Oberdorf IT-Consulting <info@oberdorf-itc.de>"
LABEL site.local.program.version="1.3.0"

RUN apk upgrade --available --no-cache --update \
    && apk add --no-cache --update \
       python3=3.11.6-r0 \
       py3-pip=23.1.2-r0 \
    # Cleanup APK
    && rm -rf /var/cache/apk/* /tmp/* /var/tmp/*

COPY --chown=root:root /src /

RUN pip3 install --no-cache-dir -r /requirements.txt

EXPOSE 5020/tcp

USER 1434:1434

# Start Server
ENTRYPOINT ["python", "-u", "/app/modbus_server.py"]
