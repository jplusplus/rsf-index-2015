run:
	gulp serve

build:
	gulp

install:
	npm install
	./node_modules/.bin/bower install
	gulp wiredep

deploy:
	gulp --force deploy
