
import {parse} from './parser'

export {parse}

export generate = (code) ->

  result = parse code
  # console.log 'result:', result
  html = result.map (line) ->
    lineHtml = line.map (obj) ->
      "<span class='#{obj.type}'>#{obj.text}</span>"
    .join ''
    "<span class='cirru-line'>#{lineHtml}</span>"
  .join '<br>'

  "<code class=\"cirru-color\">#{html}</code>"

export generateHtml = generate
