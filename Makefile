version=$(shell git describe --tags)
repository=go-env
user=hatlonely

.PHONY: build push

build:
	docker build --tag=${user}/${repository}:${version} .

deploy:
	if [ ! -z "$(shell docker ps --filter name=test-mysql -q)" ]; then \
		docker stop test-mysql && docker rm test-mysql; \
	fi
	docker run --name go-build-env --network testnet -d hatlonely/${repository}:${version} tail -f /dev/null; \

push:
	docker push ${user}/${repository}:${version}
