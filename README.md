
Cirru Color
------

Syntax highlighting tool inspired by Pygements

Demo http://repo.cirru.org/cirru-color/

It's mainly based on my [PR on pygments][pr] for adding Cirru highlighting.

[pr]: https://github.com/pygments/pygments/blob/master/pygments/lexers/webmisc.py#L866

### Usage

```bash
npm install cirru-color
```

```coffee
{generate, parse} = require 'cirru-color'
tokens = parse 'cirru code'
html = generate 'cirru code'
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
```

Colors are defined in `css/cirru.css`

![](http://cirru.qiniudn.com/cirru-color.png)

### License

MIT
