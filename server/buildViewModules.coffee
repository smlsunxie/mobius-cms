gulp = require("gulp")
browserify = require('gulp-browserify');
distPath = "client/app"
$q = require("bluebird");

buildViewModules = () ->
  console.log "=== buildViewModules ==="
  defer = $q.defer();
  gulp.src("app/scripts/app.js")
  .pipe(browserify(
    insertGlobals: true
    transform: ["reactify"]
  ))
  # .on('prebundle', (bundle)->
  #   bundle.require("../../client/lbclient/lbclient.js", { expose: 'lbclient' })
  #   boot.compileToBrowserify({
  #     appRootDir: distPath + "/lbclient",
  #     env: "development"
  #   }, bundle)
  # )
  .pipe(gulp.dest(distPath + "/scripts"))
  .on('end', () ->
    defer.resolve()
  )



  return defer.promise;

module.exports = buildViewModules
