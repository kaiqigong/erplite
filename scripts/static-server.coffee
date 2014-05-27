staticServer = require('node-static')
http = require('http')
util = require('util')

webroot = './public'
port = 8080

file = new(staticServer.Server)(webroot, {
	cache: 600,
	headers: { 'X-Powered-By': 'node-static' }
})

http.createServer((req, res) ->
	req.addListener('end', () ->
		file.serve(req, res, (err, result) ->
				if err
					console.error('Error serving %s - %s', req.url, err.message)
					if err.status is 404 or err.status is 500
						file.serveFile(util.format('/%d.html', err.status), err.status, {}, req, res)
					else
						res.writeHead(err.status, err.headers)
						res.end()
				else
					console.log('%s - %s', req.url, res.message)
		)
	)
).listen(port)

console.log('node-static running at http://localhost:%d', port)
