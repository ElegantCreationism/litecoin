.PHONY: build run scan

build:
	docker build . -t elegantcreationism/litecoin:0.18.1

run:
	docker run elegantcreationism/litecoin:0.18.1

scan:
	docker scan elegantcreationism/litecoin:0.18.1 --file=./Dockerfile

push:
	docker push docker.io/elegantcreationism/litecoin:0.18.1
