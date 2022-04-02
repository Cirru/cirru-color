
import {generate} from './generator'

fetch("./examples/cirru.cirru")
.then (res) -> res.text()
.then (text) ->
  html = generate text
  document.querySelector('#container').innerHTML = html