#!/usr/bin/make -sf

# force use of Bash
SHELL := /bin/bash
INTERACTIVE=true


.PHONY: default
default: usage
usage:
	@printf "usage:"
	@printf "\tmake build-pure-on FISH_VERSION=3.1.2\t# build container\n"
	@printf "\tmake test-pure-on  FISH_VERSION=3.1.2\t# run tests\n"
	@printf "\tmake dev-pure-on   FISH_VERSION=3.1.2\t# dev in container\n"

.PHONY: build-pure-on
build-pure-on:
	docker build \
		--file ./Dockerfile \
		--build-arg FISH_VERSION=${FISH_VERSION} \
		--tag=pure-on-fish-${FISH_VERSION} \
		./

.PHONY: dev-pure-on
dev-pure-on: CMD?=fish
dev-pure-on:
	docker run \
		--name run-pure-on-${FISH_VERSION} \
		--rm \
		--interactive \
		--tty \
		--volume=$$(pwd):/tmp/.pure/ \
		pure-on-fish-${FISH_VERSION} "${CMD}"

# Don't override COPY directive as `--volume` doesnt play nice with Travis
.PHONY: test-pure-on
test-pure-on: export CMD=fishtape tests/*.test.fish  # can be overriden by user
test-pure-on:
	docker run \
		--name run-pure-on-${FISH_VERSION} \
		--rm \
		--interactive \
		--tty \
		pure-on-fish-${FISH_VERSION} "${CMD}"
