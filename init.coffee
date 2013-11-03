
requirejs.config
  baseUrl: '/js'
  
  shim:
    'uploader':
      deps: ['jquery']
    'bootstrap':
      deps: ['jquery']
    'typeahead':
      deps: ['jquery']
  
  paths:
    socket:       '/vendor/socket-0-0-1'
    
    bootstrap:    '/vendor/bower_components/bootstrap/dist/js/bootstrap'
    cookie:       '/vendor/bower_components/jquery.cookie/jquery.cookie'
    jquery:       '/vendor/bower_components/jquery/jquery'
    notification: '/vendor/bower_components/twbs3.jquery.notification/index'
    typeahead:    '/vendor/bower_components/typeahead.js/dist/typeahead'
    uploader:     '/vendor/bower_components/jquery.uploader/index'
    
    socketIo:     '/vendor/jsLibs/socket.io-0-9-16'
    ko:           '/vendor/jsLibs/knockoutjs-3-0-0'
  
  map:
    '*':
      jq: 'jquery'
      $:  'jquery'

require ['jq', 'socket'] , ($, socket) ->
  console.dir $.fn.jquery

  $.ajaxSetup cache:false
  
  ($ document).ready ->
    socket.init()
