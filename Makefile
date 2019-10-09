version=$(shell git describe --tags)
repository=go-env
user=hatlonely

.PHONY: build push

build:
	docker build --tag=${user}/${repository}:${version} .

deploy:
	if [ ! -z "$(shell docker ps --filter name=go-build-env -q)" ]; then \
		docker stop go-build-env  && docker rm go-build-env; \
	fi
	docker run --name go-build-env --network testnet -d hatlonely/${repository}:${version} tail -f /dev/null; \

push:
	docker push ${user}/${repository}:${version}
