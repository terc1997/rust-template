#!/bin/sh

.PHONY: all

# Env vars
DOCKER_USERNAME?=localhost
GITHUB_REF?=refs/head/dev

fmt:
	cargo fmt --all --manifest-path ./image/Cargo.toml --check

run:
	cargo run --manifest-path ./image/Cargo.toml

install:
	cargo install --path ./image

test:
	cargo test --target-dir ./image --manifest-path ./image/Cargo.toml

build:
	cargo build --target-dir ./image --manifest-path ./image/Cargo.toml

docker-build:
	podman build -t ${DOCKER_USERNAME}/apps/rust-app:latest -f /image/Dockerfile .

docker-push: docker-build
	podman login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD} docker.io
	export BRANCH=$(echo ${GITHUB_REF} | sed "s/.*\\///g")
	podman tag ${DOCKER_USERNAME}/apps/rust-app:latest ${DOCKER_USERNAME}/apps/rust-app:${BRANCH}_${BUILD_NUMBER}
	podman push ${DOCKER_USERNAME}/apps/rust-app:${BRANCH}_${BUILD_NUMBER}
