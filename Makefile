setup: drop-containers start-containers composer-install

drop-containers:
	docker compose kill
	docker compose rm --force

start-containers:
	DOCKERCOMPOSE_USERID=`id -u` DOCKERCOMPOSE_GROUPID=`id -g` docker compose --env-file .docker/.env up --build --detach

composer-install:
	docker compose exec php composer install --no-interaction
