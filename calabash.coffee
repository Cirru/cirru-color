
require("calabash").do "task",
  "pkill -f doodle"
  "coffee -o src/ -wbc coffee/"
  'watchify -o build/build.js src/render.js -v'
  "doodle src/ index.html cirru/"