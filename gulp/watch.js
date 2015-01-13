'use strict';

var gulp = require('gulp');

gulp.task('watch', ['consolidate', 'wiredep', 'injector:css', 'injector:js', 'locale'] ,function () {
  gulp.watch('src/{app,components}/**/*.less', ['injector:css']);
  gulp.watch('src/{app,components}/**/*.{js,coffee}', ['injector:js']);
  gulp.watch('src/assets/images/**/*', ['images']);
  gulp.watch('bower.json', ['wiredep']);
  gulp.watch('src/{app,components}/**/*.jade', ['consolidate:jade']);
  gulp.watch('locale/**/*.json', ['locale']);
});
