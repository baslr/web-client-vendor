web-client-vendor
=================

defaults with requirejs and bower

## how to install

### git submodule

```
$ git submodule add path/to/vendor https://github.com/baslr/web-client-vendor
$ git submodule init
$ git submodule update
$ cd path/to/vendor
$ bower install
```

in your index.html ```<head>``` insert


```html
<script type="text/javascript" data-main="/vendor/init" src="/vendor/require.js"></script>
```

the your app file should look like this:

```coffeescript

define (require, exports, module) ->
  module.exports = ->
    console.log 'I was called'
    
  undefined
```

to disable authentification via websockets just configure it with requirejs config:

```coffeescript
requirejs.config
  config:
    socket:
      auth: false
```


minimal Websocket backend

```coffeescript
on 'auth', (key) ->
  if key is valud
    emit 'userName', userName
  else
    emit 'login'

on 'login', (email, password) ->
  if email is valid and password is valid
    generate key
    emit 'key', newKey
    emit 'userName', userName
  else
    emit 'login'

