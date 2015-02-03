run:
	gulp serve

build:
	gulp

install:
	npm install
	./node_modules/.bin/bower install
	gulp wiredep

deploy:
	gulp  deploy

crowdin_upload:
	crowdin-cli upload sources

crowdin_download:
	crowdin-cli download
