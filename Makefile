# Docker compose file location
COMPOSE		=	docker-compose.yml

# Change this to suit your compose version

COMPOSE_CMD = docker-compose -f ${COMPOSE}
# COMPOSE_CMD	= 	docker compose -f ${COMPOSE}

# BASIC COMPOSE COMMANDS
build:
	${COMPOSE_CMD} up --build

up:
	${COMPOSE_CMD} up

down:
	${COMPOSE_CMD} down

# CLEAN DATABASES
clean: down
	docker volume prune -f

# PRUNE DOCKER CONTAINERS
fclean: down clean
	docker system prune -af

re: fclean build

.PHONY: all build up down clean fclean