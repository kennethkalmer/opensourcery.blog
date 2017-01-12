var gulp = require('gulp');
var sass = require('gulp-sass');
var babel = require('gulp-babel');
var concat = require('gulp-concat');

gulp.task('styles', function() {
    return gulp.src('styles/**/*.scss')
        .pipe(sass().on('error', sass.logError))
        .pipe(gulp.dest('./tmp/stylesheets/'));
});

gulp.task('scripts', function() {
    return gulp.src(['scripts/jquery.js', 'scripts/**/*.js'])
        .pipe(babel({presets: ['es2015']}))
        .pipe(concat('all.js'))
        .pipe(gulp.dest('./tmp/javascripts/'));
});

gulp.task('default',function() {
    gulp.watch('styles/**/*.scss', ['styles']);
    gulp.watch('scripts/**/*.js', ['scripts']);
});
