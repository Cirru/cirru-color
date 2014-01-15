
class State
  constructor: ->
    @list = ['line', 'func']
  get: ->
    last = @list[@list.length - 1]
    throw new Error 'Empty state list' unless last?
    last
  push: (state) ->
    console.log 'push state:', state, '->>', @list
    @list.push state
  pop: (message) ->
    state = @list.pop()
    console.log 'pop state:', state, '->>', @list, message

tokenize = (line) ->
  state = new State
  collection = []
  console.group 'tokenize'

  isWhitespace = ->
    if whitespace = line.match /^\s+/
      collection.push type: 'whitespace', text: whitespace[0]
      line = line[whitespace[0].length..]
      true
    else false

  isFunc = ->
    if func = line.match /^[^\"\(\)\$\s]+\b/
      collection.push type: 'func', text: func[0]
      state.pop 'func end'
      line = line[func[0].length..]
      true
    else false

  isPara = ->
    if para = line.match /^[^\"\(\)\$\s]+\b/
      collection.push type: 'para', text: para[0]
      line = line[para[0].length..]
      true
    else false

  isDollar = ->
    if dollar = line.match /^\$\b/
      collection.push type: 'dollar', text: dollar[0]
      state.push 'func'
      line = line[1..]
      true
    else false

  isClose = ->
    if close = line.match /^\)/
      collection.push type: 'close', text: ')'
      line = line[1..]
      true
    else false

  isFuncClose = ->
    if close = line.match /^\)/
      collection.push type: 'close', text: ')'
      state.pop 'close'
      line = line[1..]
      true
    else false

  isOpen = ->
    if open = line.match /^\(/
      collection.push type: 'open', text: '('
      line = line[1..]
      state.push 'func'
      true
    else false

  isString = ->
    if open = line.match /^\"\b/
      collection.push type: 'punc', text: '"'
      line = line[1..]
      state.push 'string'
      true
    else false

  isStringContent = ->
    if content = line.match /^[^\"\\]+/
      collection.push type: 'string', text: content[0]
      line = line[content[0].length..]
      true
    else false

  isEscape = ->
    if punc = line[0] is '\\'
      collection.push type: 'escape', text: '\\'
      line = line[1..]
      state.push 'escape'
      true
    else false

  isEscapeContent = ->
    if (content = line[0])?
      collection.push type: 'escapeContent', text: content
      line = line[1..]
      state.pop 'escape end'
      true
    else false

  isStringEnd = ->
    if content = line.match /^\"\b/
      collection.push type: 'punc', content: '"'
      line = line[1..]
      state.pop 'string end'
      true
    else false

  rules =
    string: ->
      return if isEscape()
      return if isStringContent()
      new Error "not in string grammar: >>>#{line}<<<"
    func: ->
      return if isWhitespace()
      return if isFunc()
      return if isDollar()
      return if isFuncClose()
      return if isOpen()
      new Error "not in func grammar: >>>#{line}<<<"
    escape: ->
      return if isEscapeContent
      new Error "not in escape grammar: >>>#{line}<<<"
    line: ->
      return if isWhitespace()
      return if isPara()
      return if isOpen()
      return if isClose()
      return if isDollar()
      new Error "not in line grammar: >>>#{line}<<<"

  count = 0
  console.log('state is:', state.list, line)
  while line.length > 0
    rules[state.get()]()
    count += 1
    if count > 400
      console.warn "failed at line: >>>#{line}<<< when >>>#{state.get()}<<<"
      break

  console.groupEnd 'tokenize'
  collection

define (require, exports) -> (code) ->
  lines = code.split('\n').map tokenize