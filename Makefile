HARP		:= ./node_modules/harp/bin/harp

.PHONY: clean
clean:
	rm -rf www/*

.PHONY: setup
setup:
	npm install harp

build:	
	$(HARP) compile

.PHONY: deploy
deploy:
	echo "TODO"

run:
	$(HARP) server
