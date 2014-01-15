
define (require, exports) -> (code) ->
  parser = require 'src/parser'

  result = parser code
  console.log 'result:', result
  'return from generator'