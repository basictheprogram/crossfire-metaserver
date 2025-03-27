# Load environment variables from .env file
include .env

run::
    docker compose -f docker-compose.yml up -d mysql
    docker compose -f docker-compose.yml up --build --force-recreate -d www
    docker compose -f docker-compose.yml restart www
    docker image prune -af
