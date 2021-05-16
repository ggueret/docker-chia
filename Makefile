GIT_REVISION ?= main

build:
	docker build --build-arg GIT_REVISION=${GIT_REVISION} -t ggueret/docker-chia:${GIT_REVISION} .

shell:
	docker run --rm -ti --entrypoint /bin/bash ggueret/docker-chia:${GIT_REVISION}
