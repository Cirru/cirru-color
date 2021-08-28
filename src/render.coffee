
import {generate} from './generator'

req = new XMLHttpRequest
req.open 'GET', './examples/cirru.cirru'
req.onload = ->
  html = generate req.responseText

  document.querySelector('#container').innerHTML = html

req.send()
