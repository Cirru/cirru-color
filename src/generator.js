// Generated by CoffeeScript 1.6.3
(function() {
  define(function(require, exports) {
    return function(code) {
      var html, parser, result;
      parser = require('src/parser');
      result = parser(code);
      console.log('result:', result);
      html = result.map(function(line) {
        var lineHtml;
        lineHtml = line.map(function(obj) {
          return "<span class='" + obj.type + "'>" + obj.text + "</span>";
        }).join('');
        return "<span class='cirru-line'>" + lineHtml + "</span>";
      }).join('<br>');
      return "<pre class='cirru-color'><code>" + html + "</code></pre>";
    };
  });

}).call(this);

/*
//@ sourceMappingURL=generator.map
*/