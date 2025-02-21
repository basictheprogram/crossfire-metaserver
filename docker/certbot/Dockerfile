FROM certbot/certbot:latest

RUN mkdir -p /opt/certbot
COPY certify-init.sh /opt/certbot
RUN chmod +x /opt/certbot/certify-init.sh

ENTRYPOINT []
CMD ["certbot", "renew"]
