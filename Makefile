SHELL := /bin/bash

BUILD_DATE := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
GIT_COMMIT := $(shell git rev-parse HEAD)
IMAGE_NAME := "linux-101"
TAG := $(GIT_COMMIT)
TAG_SUFFIX := $(shell echo -SNAPSHOT)

################################ Docker Targets ###############################

.PHONY: docker-build
docker-build: $(DOCKER_BUILD_TARGETS)
	@docker build \
		-t $(IMAGE_NAME):"$(TAG)$(TAG_SUFFIX)" \
		-f docker/Dockerfile \
		.

.PHONY: tag-latest
tag-latest: docker-build
	docker tag ${IMAGE_NAME}:"${TAG}-SNAPSHOT" ${IMAGE_NAME}:latest


.PHONY: run-local
run-local:
	sed -e 's|<container-version>|$(TAG)$(TAG_SUFFIX)|g' docker-compose.yml | docker-compose --project-name linux-101 -f /dev/stdin up -d

.PHONY: stop-local
stop-local:
	docker stop linux-101_linux-101_1