# Load environment variables from .env file
include .env

build::
	docker compose -f docker-compose.yml build

run::
	docker compose -f docker-compose.yml up -d mysql
<<<<<<< HEAD
	docker compose -f docker-compose.yml up --build --force-recreate -d www
=======
	docker compose -f docker-compose.yml up -d www
>>>>>>> 031df67ee56f8c586c97088d5151c7074372d960
	docker compose -f docker-compose.yml restart www
