# Makefile for {{cookiecutter.project_name}}

# Variables
DOCKER_IMAGE_DEV = {{cookiecutter.project_name}}_dev
DOCKER_IMAGE_PROD = {{cookiecutter.project_name}}_prod
DOCKER_COMPOSE_DEV = docker-compose -f dev.yaml
DOCKER_COMPOSE_PROD = docker-compose -f prod.yaml

.PHONY: help build-dev build-prod run-dev run-prod build-cli run-cli clean

help:
	@echo "Available targets:"
	@echo "  build-dev        - Build the development Docker image"
	@echo "  build-prod       - Build the production Docker image"
	@echo "  run-dev          - Run the development environment with Docker Compose"
	@echo "  run-prod         - Run the production environment with Docker Compose"
	@echo "  build-cli        - Build the application without Docker"
	@echo "  run-cli          - Run the application without Docker"
	@echo "  clean            - Clean up Docker containers and volumes"

build-dev:
	docker build -t $(DOCKER_IMAGE_DEV) -f docker/Dockerfile.dev .

build-prod:
	docker build -t $(DOCKER_IMAGE_PROD) -f docker/Dockerfile.prod .

run-dev:
	$(DOCKER_COMPOSE_DEV) up

run-prod:
	$(DOCKER_COMPOSE_PROD) up

down-dev:
	$(DOCKER_COMPOSE_DEV) down
	
down-prod:
	$(DOCKER_COMPOSE_PROD) down
	
build-cli:
	go build -o {{cookiecutter.project_name}} cmd/server/*.go

run-cli:
	./{{cookiecutter.project_name}}

clean:
	$(DOCKER_COMPOSE_DEV) down -v
	$(DOCKER_COMPOSE_PROD) down -v
