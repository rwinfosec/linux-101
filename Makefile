SHELL := /bin/bash

BUILD_DATE := $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
GIT_COMMIT := $(shell git rev-parse HEAD)
IMAGE_NAME := "test"
TAG := $(GIT_COMMIT)
TAG_SUFFIX := $(shell echo -SNAPSHOT)
VCS_URL := $(shell git config --get remote.origin.url)
DOCKER_ENV_BUILD_ARG := $(shell echo "--build-arg ENVIRONMENT=local")

################################ Docker Targets ###############################

.PHONY: docker-build
docker-build: $(DOCKER_BUILD_TARGETS)
	@docker build \
		--build-arg VCS_REF="$(TAG)$(TAG_SUFFIX)" \
		--build-arg VCS_URL="$(VCS_URL)" \
		--build-arg BUILD_DATE="$(BUILD_DATE)" \
		--build-arg VERSION="$(TAG)" \
		$(DOCKER_ENV_BUILD_ARG) \
		-t $(IMAGE_NAME):"$(TAG)$(TAG_SUFFIX)" \
		-f docker/Dockerfile \
		.

.PHONY: tag-latest
tag-latest: docker-build
	docker tag ${IMAGE_NAME}:"${TAG}-SNAPSHOT" ${IMAGE_NAME}:latest