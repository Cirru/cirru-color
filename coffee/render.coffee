
{generate} = require './generator'

req = new XMLHttpRequest
req.open 'GET', './cirru/cirru.cirru'
req.onload = ->
  html = generate req.responseText

  document.querySelector('#container').innerHTML = html

req.send()