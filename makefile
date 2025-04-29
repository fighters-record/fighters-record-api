# Makefile for fighters-record-api

up:
	docker compose up

upd:
	docker compose up -d

down:
	docker compose down

build:
	docker compose build --no-cache

prod-up:
	docker compose -f docker-compose.prod.yml up --build

bash:
	docker compose exec api bash

db-create:
	docker compose exec api rails db:create

db-migrate:
	docker compose exec api rails db:migrate

console:
	docker compose exec api rails c

logs:
	docker compose logs -f api

lint:
	bundle exec rubocop

lint-fix:
	bundle exec rubocop -A

# lint-ci:
# TODO: 将来的にやるよ