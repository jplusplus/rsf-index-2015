'use strict';

var gulp = require('gulp');
var slug = require('slug');

var $ = require('gulp-load-plugins')({
  pattern: ['gulp-*', 'main-bower-files', 'uglify-save-license', 'del']
});

gulp.task('styles', ['wiredep', 'injector:css:preprocessor'], function () {
  return gulp.src(['src/app/index.less', 'src/app/vendor.less'])
    .pipe($.less({
      paths: [
        'src/bower_components',
        'src/app',
        'src/components'
      ]
    }))
    .on('error', function handleError(err) {
      console.error(err.toString());
      this.emit('end');
    })
    .pipe($.autoprefixer())
    .pipe(gulp.dest('.tmp/app/'));
});

gulp.task('injector:css:preprocessor', function () {
  return gulp.src('src/app/index.less')
    .pipe($.inject(gulp.src([
        'src/{app,components}/**/*.less',
        '!src/app/index.less',
        '!src/app/vendor.less'
      ], {read: false}), {
      transform: function(filePath) {
        filePath = filePath.replace('src/app/', '');
        filePath = filePath.replace('src/components/', '../components/');
        return '@import \'' + filePath + '\';';
      },
      starttag: '// injector',
      endtag: '// endinjector',
      addRootSlash: false
    }))
    .pipe(gulp.dest('src/app/'));
});

gulp.task('injector:css', ['styles'], function () {
  return gulp.src('src/index.html')
    .pipe($.inject(gulp.src([
        '.tmp/{app,components}/**/*.css',
        '!.tmp/app/vendor.css'
      ], {read: false}), {
      ignorePath: '.tmp',
      addRootSlash: false
    }))
    .pipe(gulp.dest('src/'));
});

gulp.task('scripts', function () {
  return gulp.src('src/{app,components}/**/*.coffee')
    .pipe($.coffeelint())
    .pipe($.coffeelint.reporter())
    .pipe($.coffee())
    .on('error', function handleError(err) {
      console.error(err.toString());
      this.emit('end');
    })
    .pipe(gulp.dest('.tmp/'))
    .pipe($.size());
});

gulp.task('injector:js', ['scripts', 'injector:css'], function () {
  return gulp.src(['src/index.html', '.tmp/index.html'])
    .pipe($.inject(gulp.src([
      '{src,.tmp}/{app,components}/**/*.js',
      '!src/{app,components}/**/*.spec.js',
      '!src/{app,components}/**/*.mock.js'
    ]).pipe($.angularFilesort()), {
      ignorePath: ['src', '.tmp'],
      addRootSlash: false
    }))
    .pipe(gulp.dest('src/'));
});

gulp.task('partials', ['consolidate'], function () {
  return gulp.src(['src/{app,components}/**/*.html', '.tmp/{app,components}/**/*.html'])
    .pipe($.minifyHtml({
      empty: true,
      spare: true,
      quotes: true
    }))
    .pipe($.angularTemplatecache('templateCacheHtml.js', {
      module: 'rsfIndex2015'
    }))
    .pipe(gulp.dest('.tmp/inject/'));
});

gulp.task('html', ['wiredep', 'injector:css', 'injector:js', 'partials'], function () {
  var htmlFilter = $.filter('*.html');
  var jsFilter = $.filter('**/*.js');
  var cssFilter = $.filter('**/*.css');
  var assets;

  return gulp.src(['src/*.html', '.tmp/*.html'])
    .pipe($.inject(gulp.src('.tmp/inject/templateCacheHtml.js', {read: false}), {
      starttag: '<!-- inject:partials -->',
      ignorePath: '.tmp',
      addRootSlash: false
    }))
    .pipe(assets = $.useref.assets())
    .pipe($.rev())
    .pipe(jsFilter)
    .pipe($.ngAnnotate())
    .pipe($.uglify({preserveComments: $.uglifySaveLicense}))
    .pipe(jsFilter.restore())
    .pipe(cssFilter)
    .pipe($.replace('bower_components/bootstrap/fonts','fonts'))
    .pipe($.csso())
    .pipe(cssFilter.restore())
    .pipe(assets.restore())
    .pipe($.useref())
    .pipe($.revReplace())
    .pipe(htmlFilter)
    .pipe($.minifyHtml({
      empty: true,
      spare: true,
      quotes: true
    }))
    .pipe(htmlFilter.restore())
    .pipe(gulp.dest('dist/'))
    .pipe($.size({ title: 'dist/', showFiles: true }));
});

gulp.task('images', function () {
  return gulp.src('src/assets/images/**/*')
    .pipe($.imagemin({
      optimizationLevel: 3,
      progressive: true,
      interlaced: true
    }))
    .pipe(gulp.dest('dist/assets/images/'));
});

gulp.task('assets', function () {
  return gulp.src('src/assets/{fonts,json}/*')
    .pipe(gulp.dest('dist/assets/'));
});

gulp.task('locale', function () {
  return gulp.src('locale/*/LC_MESSAGES/messages.json')
    .pipe($.rename(function (path) {
      // Extract the locale code from the dirname
      var locale = path.dirname.match(/^([a-zA-Z_-]*)\//)[1];
      // Change the final file name
      path.basename = locale;
    }))
    .pipe($.flatten())
    .pipe(gulp.dest('.tmp/assets/locale/'))
    .pipe(gulp.dest('dist/assets/locale/'));
});


gulp.task('csv', function(){
  gulp.src(['src/assets/csv/*.csv'])
    .pipe($.convert({ from: 'csv', to: 'json' }))
    .pipe($.jsonEditor(function(data) {
      var dataWithSlug = [];
      data.forEach(function(row) {
        var rowWithSlug = {};
        // For each key of this object
        for (var k in row){
          if (row.hasOwnProperty(k)) {
            // Convert it as a slug
            rowWithSlug[ slug(k, '_').toLowerCase() ] = row[k];
          }
        }
        // Add the new row
        dataWithSlug.push(rowWithSlug);
      });
      return dataWithSlug;
    }))
    .pipe(gulp.dest('.tmp/assets/json/'))
    .pipe(gulp.dest('dist/assets/json/'));
});

gulp.task('fonts', function () {
  return gulp.src($.mainBowerFiles())
    .pipe($.filter('**/*.{eot,svg,ttf,woff}'))
    .pipe($.flatten())
    .pipe(gulp.dest('dist/assets/fonts/'));
});

gulp.task('misc', function () {
  return gulp.src('src/**/*.ico')
    .pipe(gulp.dest('dist/'));
});

gulp.task('clean', function (done) {
  $.del(['dist/', '.tmp/'], done);
});


gulp.task('deploy', ['build'], function() {
  gulp.src("./dist/**/*").pipe($.ghPages({
    remoteUrl: "git@github.com:jplusplus/rsf-index-2015.git"
  }));
});


gulp.task('build', ['html', 'images', 'fonts', 'misc', 'assets', 'locale']);
