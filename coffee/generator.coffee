
{parse} = require './parser'

exports.parse = parse

exports.generate = (code) ->

  result = parse code
  # console.log 'result:', result
  html = result.map (line) ->
    lineHtml = line.map (obj) ->
      "<span class='#{obj.type}'>#{obj.text}</span>"
    .join ''
    "<span class='cirru-line'>#{lineHtml}</span>"
  .join '<br>'

  "<pre class='cirru-color'><code>#{html}</code></pre>"