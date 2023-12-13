import fs from "node:fs";
import { execSync } from "node:child_process";

let files = execSync("find lib -name '*.js'").toString().trim().split("\n");

console.log(files);

// rename all files to mns
files.forEach((file) => {
  let newFile = file.replace(".js", ".mjs");
  console.log(`Renaming ${file} to ${newFile}`);
  fs.renameSync(file, newFile);
});

let piece = "./parser";
let pieceMjs = "./parser.mjs";
let code = fs.readFileSync("lib/generator.mjs", "utf8");

// rename file
let newCode = code.replace(piece, pieceMjs);
fs.writeFileSync("lib/generator.mjs", newCode);
console.log(`replace ${piece} to ${pieceMjs}`);
