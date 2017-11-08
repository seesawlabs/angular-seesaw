# Karma configuration
# Generated on Mon Oct 19 2015 10:45:35 GMT-0500 (CDT)

module.exports = (config) ->
  config.set

    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: ''


    # frameworks to use
    # available frameworks: https://npmjs.org/browse/keyword/karma-adapter
    frameworks: ['jasmine']


    # list of files / patterns to load in the browser
    files: [
        'bower_components/angular/angular.js'
        'bower_components/angular-mocks/angular-mocks.js'
        'bower_components/angular-cookies/angular-cookies.js'
        'lib/**/*.coffee'
        'test/unit/*.spec.coffee'

        # include the directory where directive templates are stored.
        'lib/views/**/*.jade'
    ]


    # list of files to exclude
    exclude: []


    # preprocess matching files before serving them to the browser
    # available preprocessors: https://npmjs.org/browse/keyword/karma-preprocessor
    preprocessors:
      'lib/**/*.coffee': ['coffee', 'coverage']
      'test/**/*.coffee': ['coffee']
      'lib/**/*.jade': ['ng-jade2js']

    ngJade2JsPreprocessor:
      stripPrefix: 'lib/'
      prependPrefix: 'modules/seesawlabs/'
      moduleName: 'allviews'

    coffeePreprocessor:
      options:
        bare: true


    # test results reporter to use
    # possible values: 'dots', 'progress'
    # available reporters: https://npmjs.org/browse/keyword/karma-reporter
    reporters: ['progress', 'dots', 'coverage']


    # web server port
    port: 8089


    # enable / disable colors in the output (reporters and logs)
    colors: true

    coverageReporter:
      type : 'html'
      dir : 'coverage/'


    # level of logging
    # possible values:
    # - config.LOG_DISABLE
    # - config.LOG_ERROR
    # - config.LOG_WARN
    # - config.LOG_INFO
    # - config.LOG_DEBUG
    logLevel: config.LOG_INFO


    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true


    # start these browsers
    # available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    browsers: ['Chrome']


    # Continuous Integration mode
    # if true, Karma captures browsers, runs the tests and exits
    singleRun: false

    client:
        mocha:
            reporter: 'html'
            ui: 'tdd'
