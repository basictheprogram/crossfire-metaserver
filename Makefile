# Load environment variables from .env file
include .env

build::
	docker-compose -f docker-compose.yml build

run::
	docker-compose -f docker-compose.yml up -d mysql
	docker-compose -f docker-compose.yml up -d www
	docker-compose -f docker-compose.yml run --rm certbot /opt/certbot/certify-init.sh
	docker-compose -f docker-compose.yml restart www
