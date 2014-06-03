// Generated by CoffeeScript 1.7.1
(function() {
  var file, http, port, staticServer, util, webroot;

  staticServer = require('node-static');

  http = require('http');

  util = require('util');

  webroot = './public';

  port = 8080;

  file = new staticServer.Server(webroot, {
    cache: 600,
    headers: {
      'X-Powered-By': 'node-static'
    }
  });

  http.createServer(function(req, res) {
    return req.addListener('end', function() {
      return file.serve(req, res, function(err, result) {
        if (err) {
          console.error('Error serving %s - %s', req.url, err.message);
          if (err.status === 404 || err.status === 500) {
            return file.serveFile(util.format('/%d.html', err.status), err.status, {}, req, res);
          } else {
            res.writeHead(err.status, err.headers);
            return res.end();
          }
        } else {
          return console.log('%s - %s', req.url, res.message);
        }
      });
    });
  }).listen(port);

  console.log('node-static running at http://localhost:%d', port);

}).call(this);

//# sourceMappingURL=static-server.map