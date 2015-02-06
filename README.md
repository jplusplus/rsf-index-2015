# RSF: Index 2015

[Download](https://github.com/jplusplus/rsf-index-2015/archive/gh-pages.zip) • [Fork](https://github.com/jplusplus/rsf-index-2015) • [License](https://github.com/jplusplus/rsf-index-2015/blob/master/LICENSE)

## Installation

Install `node` and `npm` then run:

```bash
make install
```

You can now start serving static files with gulp!

```bash
make run
```

## Available commands

Command | Description
--- | ---
make build | Build the app to the ´dist´ directory
make crowdin_download | Downloads locales from Crowdin
make crowdin_upload | Uploads locales to Crowdin
make deploy | Deploys the app on Github Pages
make full_deploy | Downloads locales from Crowdin, commits changes and deploy on Github Pages
make install | Downloads all app's components
make run | Runs the development server on port *3000*
make zip | Builds and exports the app to a zip file

## Technical stack

This small application uses the following tools and opensource projects:

* [AngularJS](https://angularjs.org/) - Javascript Framework
* [Yeoman: gulp-angular](https://github.com/Swiip/generator-gulp-angular) - Static app generator
* [Leaflet: Angular Directive](http://tombatossals.github.io/angular-leaflet-directive/) - Leaflet Map with Angular
* [UI Router](https://github.com/angular-ui/ui-router/) - Application states manager
* [LoDash](http://lodash.com/) - Utility library
* [Bootstrap](http://getbootstrap.com/) - HTML and CSS framework
* [Less](http://lesscss.org/) - CSS pre-processor
* [CoffeeScript](http://coffeescript.org/) - Javascript pre-processor
