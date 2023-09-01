ROOT_DIR:=$(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

prepare: ## Prepare teiton-app
	docker run --rm \
		-u "$(id -u):$(id -g)" \
		-v "$(ROOT_DIR):/var/www/html" \
		-w /var/www/html \
		laravelsail/php82-composer:latest \
		composer install --ignore-platform-reqs

build: ## Build teiton-app and other containers
	./vendor/bin/sail build

install: ## Install dependencies
	./vendor/bin/sail composer install
	./vendor/bin/sail yarn install

up: ## Start teiton-app and other containers
	./vendor/bin/sail up -d

stop: ## Stop teiton-app and other containers
	./vendor/bin/sail stop

migrate: ## Run migrations
	./vendor/bin/sail artisan migrate:fresh

seed: ## Build teiton-app containers and enviroment with seeders
	./vendor/bin/sail artisan db:seed

down: ## Stop teiton-app containers
	./vendor/bin/sail down

vite: ## Run vite
	./vendor/bin/sail yarn build

.PHONY: teiton-app

teiton-go: prepare down build up install migrate vite
