
all: build start

build:
	docker-compose build

start:
	docker-compose up

clean:
	docker ps -aq | xargs docker stop
	docker ps -aq | xargs docker rm

db-init:
	docker exec -e POSTGRES_PASSWORD=pass -i vsapiv2-db-1 psql -p 5432 -U postgres vsapi < ./dbschema.sql
