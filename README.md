
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

Highlight code:

```coffee
import {generateHtml} from 'cirru-color'
html = generateHtml 'cirru code'
```

Styles in `/assets/cirru.css`.

Or just parsing:

```coffee
import {parse} from 'cirru-color'
tokens = parse 'cirru code'
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

### License

MIT
