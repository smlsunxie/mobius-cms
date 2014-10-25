"use strict"
gulp = require("gulp")
del = require("del")
path = require("path")
distPath = "client"

# Load plugins
$ = require("gulp-load-plugins")()

# Styles
gulp.task "styles", ->
  gulp.src("app/styles/main.scss").pipe($.rubySass(
    style: "expanded"
    precision: 10
    loadPath: ["app/bower_components"]
  )).pipe($.autoprefixer("last 1 version")).pipe(gulp.dest(distPath + "/styles")).pipe $.size()


# cjsx
gulp.task "cjsx", ->
  gulp.src(["app/src/**/*.cjsx"],
    base: "app/src"
  ).pipe($.cjsx(bare: true).on("error", $.util.log)).pipe gulp.dest("app/scripts")


# CoffeeScript
gulp.task "coffee", ->
  gulp.src([
    "app/src/**/*.coffee"
    "app/src/**/*.js"
  ],
    base: "app/src"
  ).pipe($.coffee(bare: true).on("error", $.util.log)).pipe gulp.dest("app/scripts")


# Scripts
gulp.task "scripts", ["cjsx", "coffee"], ->
  gulp.src("app/scripts/app.js").pipe($.browserify(
    insertGlobals: true
    transform: ["reactify"]
  )).pipe(gulp.dest(distPath + "/scripts")).pipe $.size()

gulp.task "jade", ->
  gulp.src("app/template/*.jade").pipe($.jade(pretty: true)).pipe gulp.dest(distPath + "")


# HTML
gulp.task "html", ->
  gulp.src("app/*.html").pipe($.useref()).pipe(gulp.dest(distPath + "")).pipe $.size()


# Images
gulp.task "images", ->
  gulp.src("app/images/**/*").pipe($.cache($.imagemin(
    optimizationLevel: 3
    progressive: true
    interlaced: true
  ))).pipe(gulp.dest(distPath + "/images")).pipe $.size()

gulp.task "jest", ->
  nodeModules = path.resolve("./node_modules")
  gulp.src("app/scripts/**/__tests__").pipe $.jest(
    scriptPreprocessor: nodeModules + "/gulp-jest/preprocessor.js"
    unmockedModulePathPatterns: [nodeModules + "/react"]
  )


# Clean
gulp.task "clean", (cb) ->
  del [
    distPath + "/styles"
    distPath + "/scripts"
    distPath + "/images"
  ], cb
  return


# Bundle
gulp.task "bundle", [
  "styles"
  "scripts"
  "bower"
], ->
  gulp.src("./app/*.html").pipe($.useref.assets()).pipe($.useref.restore()).pipe($.useref()).pipe gulp.dest(distPath + "")


# Build
gulp.task "build", [
  "html"
  "bundle"
  "images"
]

# Default task
gulp.task "default", [
  "clean"
  "build"
  "jest"
]

# Webserver
gulp.task "serve", ["watch"], ->
  gulp.src(distPath + "").pipe $.webserver(
    livereload: true
    port: 9000
  )
  return


# Bower helper
gulp.task "bower", ->
  gulp.src("app/bower_components/**/*.js",
    base: "app/bower_components"
  ).pipe gulp.dest(distPath + "/bower_components/")
  return

gulp.task "json", ->
  gulp.src("app/scripts/json/**/*.json",
    base: "app/scripts"
  ).pipe gulp.dest(distPath + "/scripts/")
  return


# Watch
gulp.task "watch", ["default"], ->

  # Watch .json files
  gulp.watch "app/scripts/**/*.json", ["json"]

  # Watch .html files
  gulp.watch "app/*.html", ["html"]

  # Watch .scss files
  gulp.watch "app/styles/**/*.scss", ["styles"]

  # Watch .jade files
  gulp.watch "app/template/**/*.jade", [
    "jade"
    "html"
  ]

  gulp.watch "app/src/**/*.cjsx", [
    "scripts"
    "jest"
  ]

  # Watch .coffeescript files
  gulp.watch "app/src/**/*.coffee", [
    "scripts"
    "jest"
  ]

  # Watch .js files
  gulp.watch "app/src/**/*.js", [
    "scripts"
    "jest"
  ]

  # Watch image files
  gulp.watch "app/images/**/*", ["images"]
  return
