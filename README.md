# RSF: Index 2015

[Download](https://github.com/jplusplus/rsf-index-2015/archive/gh-pages.zip) • [Fork](https://github.com/jplusplus/rsf-index-2015) • [License](https://github.com/jplusplus/rsf-index-2015/blob/master/LICENSE)  •
by [Journalism++](http://jplusplus.org/) under GNU Lesser General Public License

## Installation

Install `node` and `npm` then run:

```bash
make install
```

You can now start serving static files with gulp!

```bash
make run
```

## Configure Crowdin *(optional)*

This project relies on Crowdin to manage interface translations. To be able to submit and download translations from Crowdin, you have to follow 2 simple steps.

**Create a copy of Crozdin configuration file:**

```bash
cp crowdin.yaml.template crowdin.yaml
```

**Edit the new file ```crowdin.yaml``` to add your API key ([grab it here](https://crowdin.com/project/rsf-index-2015/settings#api)):**


```yaml
project_identifier: rsf-index-2015
base_url: https://api.crowdin.com
preserve_hierarchy: true
api_key: <ADD YOUR API KEY HERE>

files:
  -
    source: /locale/en/LC_MESSAGES/messages.json
    translation: /locale/%two_letters_code%/LC_MESSAGES/%original_file_name%
```

You can now run ```make crowdin_download``` to grab translations from the Crowdin website.

## Available commands

Command | Description
--- | ---
`make build` | Build the app to the `dist` directory
`make crowdin_download` | Downloads locales from Crowdin
`make crowdin_upload` | Uploads locales to Crowdin
`make deploy` | Deploys the app on Github Pages
`make full_deploy` | Downloads locales from Crowdin, commits changes and deploys on Github Pages
`make install` | Downloads all app's components
`make run` | Runs the development server on port *3000*
`make zip` | Builds and exports the app to a zip file

## Publish pages

This project allows you to publish pages using markdowns files. There is 3 directories containing those files; each one is allocated to a category within the app.

Directory | Description
--- | ---
`src/assets/markdowns/commons` | Common pages, not available under a site's specific domain
`src/assets/markdowns/highlights` | Highlights pages, listed on [index.rsf.org/#!/highlights](http://index.rsf.org/#!/highlights)
`src/assets/markdowns/themes` | Themes pages, listed on [index.rsf.org/#!/themes](http://index.rsf.org/#!/themes)

To create a page, simply create a markdown file into the right directory. At the begining of your file, use the following syntax to specify per-page options:

```markdown
---
slug: lorem
title: Lorem ispum dolor sit like a Sir
description: This is an example file.
lang: en
picture: http://www.danstapub.com/wp-content/uploads/2013/05/danstapub-reporter-sans-frontiere-betc-liberte-presse-dictateur-nouvelle-campagne-4.jpg
---

## Quaerere educere ruunt

Lorem markdownum campis invaserat fuit ora data extemplo, **micantes**. Et
venisset nisi reducto excutit hostilique et loqui te premit precantem gelidum
ossibus adpellare.

```

There is two important options here: `lang` that contains the language code of the page and `slug` that identifies your page. This last option can be shared between files. This way you can translate a given file using the same `slug` but with a different `lang` value. If you store its file in `highlights` directory, the exemple above will be avalaible in *english* at [/highlights/lorem](http://index.rsf.org/#!/highlights/lorem).

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
