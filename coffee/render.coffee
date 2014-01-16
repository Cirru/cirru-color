
define (require, exports) ->

  generator = require 'src/generator'
  code = require 'text!cirru/cirru.cirru'

  html = generator code

  document.querySelector('#container').innerHTML = html