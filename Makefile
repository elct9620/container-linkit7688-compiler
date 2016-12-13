all: build

build:
	docker build -t elct9620/linkit7688-toolchain .

run: build
	docker run -v `pwd`/app:/usr/src/app -it --rm elct9620/linkit7688-toolchain /bin/bash

push:
	docker push elct9620/linkit7688-toolchain
