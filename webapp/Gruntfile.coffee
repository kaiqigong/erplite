module.exports = (grunt) ->
	apps = 'Calendar,Common,Contact,Message,Task'
	grunt.initConfig
		pkg: grunt.file.readJSON('package.json'),

		less:
			tmp:
				options:
					compress: false,
					stdout: true,
					stderr: true
				files: [
					{
						expand: true,
						cwd: 'css',
						src: ['main.less'],
						dest: '.tmp/css',
						ext: '.css'
					}
				]

		coffee:
			tmp:
				files: [
					{
						expand: true,
						cwd: '',
						src: ['{' + apps + ',js}/{,*/,*/*/}*.coffee'],
						dest: '.tmp/js',
						rename: (dest, src) ->
							return dest + '/' + src.replace(/\.coffee$/, '.js');
					}
				]

		watch:
			less:
				files: ['{' + apps + ',css}/{,*/,*/*/}*.less'], # /**/*.less
				tasks: [ 'less:tmp']
			coffee:
				files: ['{' + apps + ',js}/{,*/,*/*/}*.coffee'], # /**/*.less
				tasks: ['coffee:tmp', 'concat:tmp']
			copy:
				files: ['{' + apps + '}' + '/views/*.html', '*.html'
						'img/{,*/}*.*'
						'mockData/*.json'
						'views/{,*/}*.html'], # /**/*.less
				tasks: ['coffee:tmp', 'concat:tmp']

		concat:
			tmp:
				src: ['bower_components/jquery/dist/jquery.min.js'
					  'bower_components/bootstrap/dist/js/bootstrap.min.js'
					  'bower_components/danialfarid-angular-file-upload/dist/angular-file-upload-shim.min.js'
					  'bower_components/angular/angular.min.js'
					  'bower_components/danialfarid-angular-file-upload/dist/angular-file-upload.min.js'
					  'bower_components/angular-route/angular-route.min.js'
					  'bower_components/angular-cookies/angular-cookies.min.js'
					  'bower_components/angular-cache/dist/angular-cache.min.js'
					  'bower_components/angular-animate/angular-animate.min.js'
					  'bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js'
					  'bower_components/lodash/dist/lodash.min.js'
					  'bower_components/restangular/dist/restangular.min.js'
					  'bower_components/momentjs/min/moment.min.js'
					  'bower_components/twix/bin/twix.min.js'
					  'bower_components/firebase/firebase.js'
					  'bower_components/angularfire/angularfire.js'

					  '.tmp/js/Common/js/init.js'
					  '.tmp/js/Common/js/factories.js'
					  '.tmp/js/js/animations.js'
					  '.tmp/js/js/app.js'
					  '.tmp/js/js/controllers.js'
					  '.tmp/js/js/filters.js'
					  '.tmp/js/js/directives.js'
					  '.tmp/js/js/services.js'
					  '.tmp/js/Contact/js/init.js'
					  '.tmp/js/Contact/js/contactModels.js'
					  '.tmp/js/Contact/js/contactManagers.js'
					  '.tmp/js/Contact/js/contactControllers.js'
					  '.tmp/js/Calendar/js/init.js'
					  '.tmp/js/Calendar/js/calendarControllers.js'
					  '.tmp/js/Calendar/js/calendarDirectives.js'
					  '.tmp/js/Task/js/init.js'
					  '.tmp/js/Task/js/taskControllers.js'
					  '.tmp/js/Message/js/init.js'
					  '.tmp/js/Message/js/messageControllers.js'
				]
				dest: '.tmp/js/main.js'

		ngmin:
			dist:
				files: [
					{
						expand: true,
						cwd: '.tmp/js',
						src: '*.js',
						dest: 'dist/js/'
					}
				]

		uglify:
			dist:
				files:
					'dist/js/main.js': ['dist/js/main.js']

		#something wrong!
		cssmin:
			dist:
				options:
					keepSpecialComments:0
				files:
					'dist/css/main.css': ['dist/css/main.css']

		htmlmin:
			dist:
				options:
					collapseWhitespace: true,
					conservativeCollapse: true,
					collapseBooleanAttributes: true,
					removeCommentsFromCDATA: true,
					removeOptionalTags: true
				files: [
					{
						expand: true,
						cwd: '.tmp',
						src: ['*.html', 'views/{,*/}*.html','{' + apps + '}' + '/views/*.html'],
						dest: 'dist'
					}
				]

		copy:
			tmp:
				files: [
					{
						expand: true
						dot: true
						dest: '.tmp'
						src: [
							'*.html'
							'img/{,*/}*.*'
							'mockData/*.json'
							'views/{,*/}*.html'
							'{' + apps + '}' + '/views/*.html'
						]
					},
					{
						expand: true,
						cwd: 'bower_components/bootstrap/dist',
						src: 'fonts/*',
						dest: '.tmp'
					},
					{
						expand: true,
						cwd: 'bower_components/font-awesome',
						src: 'fonts/*',
						dest: '.tmp'
					}
				]
			dist:
				files: [
					{
						expand: true,
						cwd: '.tmp',
						src: ['fonts/*','img/{,*/}*.*','mockData/*.json','css/main.css']
						dest: 'dist'
					},
				]


	# Load the plugin that provides the "uglify" task.
	#grunt.loadNpmTasks('grunt-exec');
	grunt.loadNpmTasks('grunt-contrib-watch');
	grunt.loadNpmTasks('grunt-contrib-concat');
	grunt.loadNpmTasks('grunt-contrib-less');
	grunt.loadNpmTasks('grunt-contrib-coffee');
	grunt.loadNpmTasks('grunt-contrib-copy');
	grunt.loadNpmTasks('grunt-ngmin');
	grunt.loadNpmTasks('grunt-contrib-uglify');
	grunt.loadNpmTasks('grunt-contrib-cssmin');
	grunt.loadNpmTasks('grunt-contrib-htmlmin');



	#compile only
	grunt.registerTask('compile', ['less', 'coffee', 'concat', 'copy']); #'exec',

	#build to dist
	grunt.registerTask('build', ['less', 'coffee', 'concat', 'copy', 'ngmin', 'uglify','cssmin','htmlmin']); #'exec',

	# Default task(s).
	grunt.registerTask('default', ['compile', 'watch']);


