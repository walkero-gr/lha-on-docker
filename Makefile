REPO ?= walkero/lha-on-docker
TAG ?= latest
NAME ?= lha-on-docker

.PHONY: build buildnc shell push logs clean test release

default: build

build:
	docker build --squash -t $(REPO):$(TAG) .

buildnc:
	docker build --no-cache --squash -t $(REPO):$(TAG) .

shell:
	docker run -it --rm --name $(NAME) $(REPO):$(TAG) /bin/bash

push:
	docker push $(REPO):$(TAG)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

test:
	snyk test --docker $(REPO):$(TAG) --file=Dockerfile

release: build push
