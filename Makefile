# Load environment variables from .env file
include .env

run::
	docker compose -f docker-compose.yml up -d mysql
	docker compose -f docker-compose.yml pull www
	docker compose -f docker-compose.yml up -d www
	docker image prune -af
