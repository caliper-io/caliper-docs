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
	ssh deploy@caliper.io -A 'cd /data/www/docs.caliper.io && git pull && make build'

run:
	$(HARP) server
