###
  leaf-grid's Gruntfile
  Author: Matheus R. Kautzmann
  Description:
    Build the project files, three main modes are available:

    * grunt watch = while developing features or fixing bugs, keeps running
    scss compilation with source maps to test with the demo HTML.

    * grunt demo = Compiles everything with source maps and spins up a server
    running the demo.

    * grunt build = Builds for distribution and output to dist.

    Also, there are some individual grunt tasks, for more info run `grunt help`

  Attention contributors: check the CONTRIBUTING.md file before sending changes.
###
module.exports = (grunt) ->

  require('load-grunt-tasks')(grunt)

  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json')

    # Lint all the CoffeeScript files
    coffeelint: {
      app: {
        files: {
          src: ['Gruntfile.coffee']
        }
      }
      test: {
        files: {
          src: ['test/*.coffee']
        }
      }
      options: {
        configFile: 'coffeelint.json'
      }
    }

    # Compile test code
    coffee: {
      test: {
        options: {
          bare: true
          sourceMap: true
        }
        files: {
          'test/testBundle.js': ['test/*.coffee']
        }
      }
    }

    # Lint SCSS files
    scsslint: {
      options: {
        bundleExec: true
        config: '.scss-lint.yml'
      }
      src: ['src/*.scss']
    }

    # Compile SCSS
    sass: {
      options: {
        bundleExec: true
      }
      demo: {
        files: {
          'demo/leaf-grid.css': 'src/leaf-grid.scss'
        }
        options: {
          style: 'expanded'
        }
      }
      test: {
        files: {
          'test/leaf-grid.css': 'src/leaf-grid.scss'
        }
        options: {
          style: 'expanded'
        }
      }
      dist: {
        files: {
          'dist/leaf-grid.css': 'src/leaf-grid.scss'
        }
        options: {
          style: 'expanded'
          sourcemap: 'none'
        }
      }
    }

    # Apply PostCSS transformations to generate complete distribution file
    postcss: {
      distDev: {
        options: {
          map: false
          processors: [
            require('autoprefixer')({browsers: 'last 2 versions'})
          ]
          banner: '/*<%= pkg.name %>@<%= pkg.version %>*/'
        }
        src: 'dist/leaf-grid.css'
        dest: 'dist/leaf-grid.css'
      }
      distProd: {
        options: {
          map: false
          processors: [
            require('cssnano')({autoprefixer: false, safe: true})
          ]
          banner: '/*<%= pkg.name %>@<%= pkg.version %>*/'
        }
        src: 'dist/leaf-grid.css'
        dest: 'dist/leaf-grid.min.css'
      }
      test: {
        options: {
          map: true
          processors: [
            require('autoprefixer')({browsers: 'last 2 versions'})
            require('cssnano')({autoprefixer: false, safe: true})
          ]
        }
        src: 'test/leaf-grid.css'
      }
    }

    # Put banner in dist files
    usebanner: {
      taskName: {
        options: {
          position: 'top',
          banner: '/*<%=pkg.name %>@<%=pkg.version%>*/',
          linebreak: true
        },
        files: {
          src: ['dist/*.css', 'dist/*.scss']
        }
      }
    }

    # Export raw SCSS file
    copy: {
      main: {
        src: 'src/leaf-grid.scss'
        dest: 'dist/_leaf-grid.scss'
      }
    }

    # Generate docs
    sassdoc: {
      default: {
        options: {
          dest: 'docs'
        }
        src: 'src/leaf-grid.scss'
      }
    }

    # Run connect server for testing purposes
    connect: {
      server: {
        options: {
          port: 8080
          base: '.'
        }
      }
    }

    # Run demo server with auto CSS update
    browserSync: {
      bsFiles: {
        src: ['demo/*.css', 'demo/*.html']
      }
      options: {
        server: {
          baseDir: './demo'
        }
      }
    }

    # Runs browser tests on Sauce Labs (only Circle CI must run it)
    'saucelabs-mocha': {
      all: {
        options: {
          username: process.env.SAUCE_USERNAME
          key: process.env.SAUCE_ACCESSKEY
          urls: ['localhost:8080/test/index.html']
          testname: 'leaf-grid'
          build: 'build-leaf-grid-' + process.env.CIRCLE_BUILD_NUM
          pollInterval: 5000
          'max-duration': 500
          maxRetries: 1
          browsers: grunt.file.readJSON('browserSupport.json').browsers
        }
      }
    }

    # Watch task while developing
    watch: {
      options: {
        spawn: false
      }
      sass: {
        files: ['src/*.scss']
        tasks: ['lint', 'sass:demo']
      }
      test: {
        files: ['test/*.coffee']
        tasks: ['coffee']
      }
    }

    # Take back to clone state
    clean: [
      'bower_components'
      'node_modules'
      'docs'
      'test/leaf-grid.css'
      'test/leaf-grid.css.map'
      'test/testBundle.js'
      'test/testBundle.js.map'
    ]
  })

  grunt.registerTask('lint', ['coffeelint', 'scsslint'])
  grunt.registerTask('test', [
    'lint'
    'coffee'
    'sass:test'
    'postcss:test'
  ])
  grunt.registerTask('docs', ['sassdoc'])
  grunt.registerTask('demo', ['sass:demo', 'browserSync'])
  grunt.registerTask('build', [
    'test',
    'sass:dist'
    'postcss:distDev'
    'postcss:distProd'
    'docs'
    'copy'
    'usebanner'
  ])
  if process.env.CI
    grunt.registerTask('ci', [
      'build'
      'connect'
      'saucelabs-mocha'
    ])
