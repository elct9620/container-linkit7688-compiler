all: build

build:
	docker build -t elct9620/lks7688-openwrt-toolchain .

run: build
	docker run -v `pwd`/app:/usr/src/app -it --rm elct9620/lks7688-openwrt-toolchain /bin/bash
