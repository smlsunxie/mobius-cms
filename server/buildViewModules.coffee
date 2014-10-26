browserify = require('browserify');
distPath = "client/app/scripts"
path = require('path');
fs = require('fs');


buildViewModules = (callback) ->
  console.log "=== buildViewModules ==="

  bundlePath = path.resolve(distPath, 'app.js');
  out = fs.createWriteStream(bundlePath);

  browserify = require('browserify');
  b = browserify();
  b.add('./app/scripts/app.js');
  b.add('./cms_modules/cms-plugin-sample/app/scripts/Todo.js');
  b.bundle()
  .on('error', callback)
  .pipe(out);

  out.on('error', callback);
  out.on('close', callback);




module.exports = buildViewModules
