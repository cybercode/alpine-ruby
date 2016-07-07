DUMMY: build
VERSION:=2.3

build:
	docker build -t cybercode/alpine-ruby:$(VERSION) $(ARGS) .
