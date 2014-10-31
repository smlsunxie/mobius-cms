"use strict"
gulp = require("gulp")
del = require("del")
path = require("path")
distPath = "client/app"
boot = require('loopback-boot')
buildClientBundle = require('./client/lbclient/build');
buildViewModules = require('./server/buildViewModules');
util = require('gulp-util');
# Load plugins
$ = require("gulp-load-plugins")()

test_module_name = util.env.module_name


# Styles
gulp.task "styles", ->
  gulp.src("app/styles/main.scss").pipe($.rubySass(
    style: "expanded"
    precision: 10
    loadPath: ["app/bower_components"]
  )).pipe($.autoprefixer("last 1 version")).pipe(gulp.dest(distPath + "/styles")).pipe $.size()


# cjsx
gulp.task "cjsx", ->
  gulp.src(["app/src/**/*.cjsx", '!app/src/**/*.js'],
    base: "app/src"
  ).pipe($.cjsx(bare: true).on("error", $.util.log)).pipe gulp.dest("app/scripts")


# CoffeeScript
gulp.task "coffee",["cjsx"] , ->
  gulp.src([
    "app/src/**/*.coffee"
    "!app/src/**/*.js"
  ],
    base: "app/src"
  ).pipe($.coffee(bare: true).on("error", $.util.log)).pipe gulp.dest("app/scripts")



# Scripts
gulp.task "scripts", ["coffee"], ->

  gulp.src('app/src/**/*.js')
  .pipe(gulp.dest(distPath + "/scripts"))
  .on("end", ->
    buildViewModules(null, ()->
      console.log "buildViewModules end"
    )
  )





gulp.task "lbclient", (done)->
  buildClientBundle(process.env.NODE_ENV || 'development', (error)->

    done()
  );

gulp.task "testmodule", ["lbclient"], ->

  gulp.src(['app/src/lbclient.js', 'client/lbclient/browser.bundle.js'])
  .pipe(gulp.dest("cms_modules/"+test_module_name+"/dist/lbclient"))
  .on("end", ->
      app = require("./server/server.coffee")
      app.start()

      app.models.Plugin.mount test_module_name, (error, result) ->
        console.log "result", result




  )





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
  "lbclient"
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


  # Watch lbclient files
  gulp.watch [
    "client/lbclient/models/*"
    "client/lbclient/app*"
    "client/lbclient/datasources*"
    "client/lbclient/models*"
    "client/lbclient/build.js"
    "client/lbclient/datasources.json"
    "client/lbclient/model-config.json"
  ], ["lbclient"]


  return
