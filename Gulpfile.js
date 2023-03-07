const gulp = require('gulp');
const sass = require('gulp-sass')(require('sass'));
const babel = require('gulp-babel');
const concat = require('gulp-concat');

function buildStyles() {
    return gulp.src('./styles/**/*.scss')
        .pipe(sass.sync().on('error', sass.logError))
        .pipe(gulp.dest('./tmp/stylesheets/'));
};

function watchStyles() {
    return gulp.watch('./styles/**/*.scss', buildStyles);
}

function buildScripts() {
    return gulp.src(['scripts/jquery.js', 'scripts/**/*.js'])
        .pipe(concat('all.js'))
        .pipe(gulp.dest('./tmp/javascripts/'));
}

function watchScripts() {
    return gulp.watch('./scripts/**/*.js', buildScripts);
}

exports.build = gulp.parallel(buildStyles, buildScripts);
exports.watch = gulp.parallel(watchStyles, watchScripts);

exports.default = gulp.parallel(watchStyles, watchScripts);
