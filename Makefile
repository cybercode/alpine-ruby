DUMMY: build
VERSION:=2.2

build:
	docker build -t cybercode/alpine-ruby:$(VERSION) $(ARGS) .
