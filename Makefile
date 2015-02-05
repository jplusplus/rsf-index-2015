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

full_deploy: crowdin_download
	git commit ./locale -m "Updated locale" || true
	git pull --rebase
	gulp deploy

zip: build
	(cd dist; zip -r ../rsf-index-2015.zip .)

crowdin_upload:
	crowdin-cli upload sources

crowdin_download:
	crowdin-cli download
