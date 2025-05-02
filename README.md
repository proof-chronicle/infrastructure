# infrastructure

This repository contains docker configuration for running projects locally

![visualisation](./docker_compose_architecture.png)


## Setup
- Install Docker
- Pull projects into the `proofchronicle` directory
- Create a `.env` file in the root of the repository by copying the `.env.example` file
- Update the `.env` file with the correct values
- Run `docker compose up -d` to start the containers

- Run `make add-local-hosts` to add the local hosts to your `/etc/hosts` file 

## Commands

- `docker compose build <service>`: Build a specific service, build all if no service is specified
- `docker compose up <service>`: Start a specific service, start all if no service is specified
- `docker compose down`: Stop all services
- `docker compose logs <service>`: View logs for a specific service, view all if no service is specified
- `docker compose exec <service> <command>`: Run a command in a specific service, for example `docker compose exec webapp /bin/sh` to open a bash shell in the web service
- `docker compose watch`: Watch for changes in the code and rebuild the containers automatically, use for working with the content-indexer
- `docker compose ps`: View the status of all services
- `docker ps -a`: View all containers
- `docker exec -it <container_id> /bin/sh`: Open a bash shell in a specific container, you can get the container id from the `docker ps` command, this command is useful for windows users who cannot use `docker compose exec` command

## laravel specific commands
- `docker compose exec webapp php artisan migrate`: Run migrations
- `docker compose exec webapp php artisan migrate --seed`: Run migrations and seed the database
- `docker compose exec webapp php artisan db:seed`: Seed the database
- `docker compose exec webapp composer install`: Install composer dependencies

You can also run any other artisan command in the same way, just replace `migrate` with the command you want to run. Also you can connect to the contaier and run commands from there.