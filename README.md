
Cirru Color
------

Syntax highlighting tool inspired by Pygements

Demo http://repo.jiyinyiyong.me/cirru-color/

It's mainly based on my [PR on pygments][pr] for adding Cirru highlighting.

[pr]: https://bitbucket.org/birkenfeld/pygments-main/pull-request/275/add-syntax-for-cirru

### Usage

```
bower install cirru-color
```

`cirru-color` has to be loaded via RequireJS.

`src/parser.js` is the core of the package, it lexes Cirru code in to an array.
After requiring the `parser`, it returns a function that would lex code.

```coffee
define (require, exports) ->
  parser = require 'cirru-color/src/parser'
  parser 'string of code'
```

valid types here are:

```
whitespace
func
para
punc
dollar
string
string-text
escape
escape-text
```

for code:

```cirru
print $ unwrap $
```

it returns:

```json
[
  [
    {
      "type": "func",
      "text": "print"
    },
    {
      "type": "whitespace",
      "text": " "
    },
    {
      "type": "dollar",
      "text": "$"
    },
    {
      "type": "whitespace",
      "text": " "
    },
    {
      "type": "func",
      "text": "unwrap"
    },
    {
      "type": "whitespace",
      "text": " "
    },
    {
      "type": "dollar",
      "text": "$"
    }
  ]
]

Colors are defined in `css/cirru.css`

![](http://cirru.org/pics/cirru-color.png)

### License

MIT