module.exports = function(app) {
  var router = app.loopback.Router();

  router.get('/module_a', function(req, res) {
    console.log("/module_a touch !!!!!!!");
    res.render('index.html');
  });


  // router.get('/projects', function(req, res) {
  //   res.render('projects');
  // });
  //
  // router.post('/projects', function(req, res) {
  //   var email = req.body.email;
  //   var password = req.body.password;
  //   app.models.User.login({
  //     email: email,
  //     password: password
  //   }, function(err, user) {
  //     if (err) {
  //       res.render('index', {
  //         email: email,
  //         password: password,
  //         loginFailed: true
  //       });
  //     } else {
  //       res.render('projects', {
  //         username: user.username,
  //         accessToken: user.id
  //       });
  //     }
  //   });
  // });
  //
  // router.get('/logout', function(req, res) {
  //   var AccessToken = app.models.AccessToken;
  //   var token = new AccessToken({id: req.query.access_token});
  //   token.destroy();
  //   res.redirect('/');
  // });

  app.use(router);
};
