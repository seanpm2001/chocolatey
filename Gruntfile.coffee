path = require 'path'
https = require 'https'

module.exports = (grunt) ->
  grunt.loadTasks('tasks')
  grunt.initConfig
    releaseUrl:
      hostname: 'api.github.com'
      path: '/repos/atom/atom/releases?per_page=1'
      headers:
        'User-Agent': 'node.js/' + process.version
    cpack:
      cmd: 'cpack.bat'
      args: ['chocolatey/atom.nuspec']
    cinst:
      cmd: 'cinst.bat'
      args: ['Atom', '-source', '%cd%']
      opts:
        cwd: path.resolve('chocolatey')
    cuninst:
      cmd: 'cuninst.bat'
      args: ['Atom']

  grunt.registerTask 'update', ['getRelease', 'updateNuspec', 'updateInstall']
  grunt.registerTask 'reinstall', ['pack', 'uninstall', 'install']
  grunt.registerTask('default', ['update', 'pack'])
