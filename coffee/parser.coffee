
class State
  constructor: ->
    @list = ['line', 'func']
  get: ->
    last = @list[@list.length - 1]
    new Error 'Empty state list' unless last?
    last
  push: (state) ->
    @list.push state
  pop: (n) ->
    n or= 1
    while n > 0
      @list.pop()
      n -= 1
    n

tokenize = (line) ->
  state = new State
  ret = []

  isWhitespace = ->
    if whitespace = line.match /^\s+/
      ret.push text: whitespace[0], type: 'whitespace'
      line = line[whitespace.length..]
      true
    else false

  isFunc = ->
    if func = line.match /^\w[^\"\(\)\$]/
      ret.push text: func[0], type: 'func'
      line = line[func..]
      true
    else false

  isPara = ->
    if para = line.match /^\w[^\"\(\)\$]/
      ret.push text: para[0], type: 'para'
      line = line[para..]
      true
    else false

  isDollar = ->
    if dollar = line[0..1] is '$ '
      ret.push text: dollar[0], type: 'dollar'
      state.push 'func'
      line = line[2..]
      true
    else false

  rules =
    string: ->
    func: ->
      return if isWhitespace()
      return if isFunc()
      return if isDollar()
    para: ->
    escape: ->
    line: ->

  count = 0
  while line.length > 0
    rules[state.get()]()
    count += 1
    if count > 400
      console.warn 'failed'
      break

  ret

define (require, exports) -> (code) ->
  lines = code.split('\n').map tokenize