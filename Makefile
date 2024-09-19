SRCS = srcs
ENV_FILE = srcs/confidential/.env
DOCKER_COMPOSE := $(shell echo "docker compose")

# 최종 배포용 v1 v2 호환
# DOCKER_COMPOSE := $(shell if command -v docker-compose >/dev/null 2>&1; then echo "sudo -E docker-compose"; else echo "docker compose"; fi)

all: dir
	@$(DOCKER_COMPOSE) -f ./${SRCS}/docker-compose.yml --env-file ${ENV_FILE} up -d

build: dir
	@$(DOCKER_COMPOSE) -f ./${SRCS}/docker-compose.yml --env-file ${ENV_FILE} up -d --build

down:
	@$(DOCKER_COMPOSE) -f ./${SRCS}/docker-compose.yml --env-file ${ENV_FILE} down -v

re: clean
	@$(DOCKER_COMPOSE) -f ./${SRCS}/docker-compose.yml --env-file ${ENV_FILE} up -d

dir:
	@bash submodule_init.sh
	@bash ${SRCS}/init_dir.sh

clean: down
	@docker image ls | grep '${SRCS}-' | awk '{print $$1}' | xargs docker image rm

fclean: down
	@docker image ls | grep '${SRCS}-' | awk '{print $$1}' | xargs docker image rm
	@docker builder prune --force
	@docker network prune --force
	@docker volume prune --force
	@bash ${SRCS}/init_dir.sh --delete

.PHONY	: all build down re clean fclean dir