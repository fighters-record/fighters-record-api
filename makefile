# Makefile for fighters-record-api

# docker起動
docker-up:
	docker compose up

# dockerデーモン起動
docker-upd:
	docker compose up -d

# 停止＋削除（volumesは残す）
docker-down:
	docker-compose down

# 停止＋volumesも含めて完全削除（DBなど初期化）
docker-nuke:
	docker-compose down -v

docker-build:
	docker compose build --no-cache

docker-prod-up:
	docker compose -f docker-compose.prod.yml up --build

docker-bash:
	docker compose exec api bash

docker-console:
	docker compose exec api rails c

docker-logs:
	docker compose logs -f api

lint:
	bundle exec rubocop

lint-fix:
	bundle exec rubocop -A

rspec:
	bin/rails db:environment:set RAILS_ENV=development
	bundle exec rspec 

# DBセットアップ
db-setup: 
	make db-create
	make db-migrate

# DB作成（development/test）
db-create:
	docker compose exec api rails db:create
	docker compose exec api rails db:create RAILS_ENV=test

# マイグレーション実行（development/test）
db-migrate:
	docker compose exec api rails db:migrate
	docker compose exec api rails db:migrate RAILS_ENV=test

# DBリセット（データ削除＋マイグレーション再実行）
db-reset:
	docker compose exec api rails db:drop RAILS_ENV=development
	docker compose exec api rails db:create RAILS_ENV=development
	docker compose exec api rails db:migrate RAILS_ENV=development

# テスト用DBをschemaからセットアップ
db-test-prepare:
	docker compose exec api rails db:create RAILS_ENV=test
	docker compose exec api rails db:schema:load RAILS_ENV=test

# TODO: 将来的にやるよ
# lint-ci:
# rspec-ci: