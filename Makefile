NAME = Inception
SRCS_DIR = srcs
DOCKER_COMPOSE = docker-compose -f $(SRCS_DIR)/docker-compose.yml
LOGIN ?= $(shell whoami)
DATA_PATH = /home/$(LOGIN)/data

all: prepare $(NAME)

prepare:
	@mkdir -p $(DATA_PATH)/wordpress
	@mkdir -p $(DATA_PATH)/mariadb
	@if [ ! -f $(SRCS_DIR)/.env ]; then \
		python3 scripts/gen_env.py --login $(LOGIN) --out $(SRCS_DIR)/.env --data-path $(DATA_PATH); \
	fi

$(NAME):
	@$(DOCKER_COMPOSE) up -d --build

down:
	@$(DOCKER_COMPOSE) down

clean:
	@$(DOCKER_COMPOSE) down --rmi all --volumes

fclean: clean
	@sudo rm -rf $(DATA_PATH)
	@docker system prune -a --force

re: fclean all

.PHONY: all prepare down clean fclean re
