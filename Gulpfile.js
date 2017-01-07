var gulp = require('gulp');
var sass = require('gulp-sass');

gulp.task('styles', function() {
    gulp.src('styles/**/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('./tmp/stylesheets/'));
});

gulp.task('default',function() {
    gulp.watch('styles/**/*.scss', ['styles']);
});
