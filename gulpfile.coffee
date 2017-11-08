# global process, require
gulp = require('gulp')
util = require('gulp-util')
connect = require('gulp-connect')
plugins = require('gulp-load-plugins')()

stylish = require('coffeelint-stylish')

Server = require('karma').Server
path = require('path')

karma = require('karma')
karmaParseConfig = require('karma/lib/config').parseConfig


coffeelint = require('gulp-coffeelint')

paths =
  lib: './lib/**/*.coffee'
  test: './test/**/*.coffee'

karmaConfFile = 'karma.conf.coffee'

runKarma = (configFilePath, options, cb)->
  configFilePath = path.resolve(configFilePath)
  log = util.log
  colors = util.colors
  config = karmaParseConfig(configFilePath, {})

  Object.keys(options).forEach (key)->
    config[key] = options[key]

  runner = new Server config, (exitCode)->
    log("Karma has exited with #{colors.red(exitCode)}")
    cb()
    process.exit(exitCode)
  runner.start()

gulp.task 'coffee', ->
  gulp.src [paths.lib]
    .pipe plugins.plumber()
    .pipe plugins.coffee
      bare: true
    .pipe plugins.concat('angular-seesaw.js')
    .pipe gulp.dest('./dist/')
    .pipe plugins.uglify()
    .pipe plugins.rename('angular-seesaw.min.js')
    .pipe gulp.dest('./dist/')
  return

gulp.task 'lint', ->
  gulp
    .src [paths.lib, paths.test]
    .pipe coffeelint()
    .pipe coffeelint.reporter(stylish)

gulp.task 'watch', ->
  gulp.watch [
      paths.lib
      paths.test
      './gulpfile.coffee'
    ], ['lint']

  gulp.start('test-dev')

gulp.task 'test-dev', (cb)->
  runKarma karmaConfFile,
    autoWatch: true
    singleRun: false
  , cb
  return

gulp.task 'test', (cb)->
  runKarma karmaConfFile,
    autoWatch: false
    singleRun: true
  , cb
  return

gulp.task 'prepare-testapp', ->
  gulp.src [
    './bower_components/**'
    './lib/**'
  ],
    base: '.'
  .pipe gulp.dest('./testapp')

  plugins('connect').server
    root: 'testapp'
    port: 3333
  return

gulp.task 'bump', ->
  gulp.src ['./bower.json','./package.json']
    .pipe plugins.bump( type: 'patch' )
    .pipe gulp.dest './'

gulp.task 'dist', ->
  gulp.start 'bump'
  gulp.start 'coffee'

gulp.task 'default', ->
  gulp.start 'lint'
  gulp.start 'dist'

gulp.task 'update', ->
  fs = require('fs')
  path = require('path')

  fs.readdirSync('./..').forEach (repo)->
    dir = "./../#{repo}"
    return if not fs.existsSync("#{dir}/bower.json")

    b = require("#{dir}/bower.json")
    # If the repo doesn't depend on `angular-seesaw` just stop
    return if not b.dependencies?['angular-seesaw']
    rc = "bower_components"

    if fs.existsSync("#{dir}/.bowerrc")
      r = fs.readFileSync "#{dir}/.bowerrc", 'utf8'
      bowerrc = JSON.parse(r)

      if bowerrc?.directory
        rc = bowerrc.directory

    path = "#{dir}/#{rc}/angular-seesaw/dist/"

    gulp.src './dist/*.js'
      .pipe gulp.dest(path)

    gulp.src './lib/views/**/*.jade'
      .pipe gulp.dest("#{dir}/src/modules/seesawlabs/views/")

    console.log path

gulp.task 'distribute', ->
  gulp.start 'coffee'
  gulp.start 'update'
