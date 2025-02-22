FROM certbot/certbot:latest

RUN mkdir -p /opt/certbot
COPY docker/certbot/certify-init.sh /opt/certbot
RUN chmod +x /opt/certbot/certify-init.sh

ENTRYPOINT []
CMD ["/opt/certbot/certbot", "renew"]
