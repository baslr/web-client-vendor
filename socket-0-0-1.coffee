
define (require, exports, module) ->
  socketIo = require 'socketIo'
  cookie   = require 'cookie'
  $        = require '$'
  app      = require 'app'
  
  require 'bootstrap'
  
  socket   = undefined
  key      = undefined
  
  window.onbeforeunload = ->
    $.cookie 'key', ''
    "Logged out, please close this tab."
  
  auth = ->
    key = $.cookie 'key'

    if key?
      console.log "Auth: try auth with key: #{key}"
      socket.emit 'auth', key
    else
      console.log "Auth: !key, try to login"
      login()
      
  login = ->
    presentDialog = ->
      ($ 'DIV#loginDialog').modal()
      ($ 'DIV#loginDialogSubSlab').css display:'block'
  
      
    if 0 is ($ 'DIV#loginDialog').length
      $.get '/jsLibs/loginDialog.html', (html) =>
        ($ 'BODY').append html
        presentDialog()
        
        ($ 'DIV#loginDialog').on 'shown.bs.modal', ->
          ($ 'INPUT#inputEmail').focus()        
        
        ($ 'BUTTON#loginDialogLogin').click =>
          socket.emit 'login', ($ 'INPUT#inputEmail').val(), ($ 'INPUT#inputPassword').val()
          ($ 'BUTTON#loginDialogClose').trigger 'click'
    else
      presentDialog()

  
  module.exports.init = ->
    socket = io.connect "#{document.location.protocol}//#{document.location.hostname}:#{document.location.port}"
    
    socket.on 'connect', ->
      auth()
      
    socket.on 'disconnect', ->
      console.log 'SOCK: disconnect'
      ($ 'DIV#loginDialogSubSlab').css display:'block'
      
    socket.on 'login', ->
      login()
      
    socket.on 'userName', (userName) ->
      console.log "received username: #{userName}"
      ($ 'DIV#loginDialogSubSlab').css display:'none'
      app()
    
    socket.on 'key', (key) ->
      console.log "Auth: received key: #{key}"
      $.cookie 'key', key
      ($ 'INPUT#inputEmail').val ''
      ($ 'INPUT#inputPassword').val ''
      app.loggedIn() if app.loggedIn?
  
  undefined
