
define (require, exports) ->

  generator = require 'src/generator'
  code = require 'text!cirru/cirru.cirru'

  generator code