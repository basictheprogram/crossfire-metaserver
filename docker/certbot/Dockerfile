FROM certbot/certbot:latest

RUN mkdir -p /opt/certbot
COPY docker/certbot/certify-init.sh /opt/certbot/certify-init.sh
RUN chmod +x /opt/certbot/certify-init.sh

ENTRYPOINT []
CMD ["/opt/certbot/certify-init.sh", "renew"]
