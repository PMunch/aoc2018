import strutils

proc reactPolymer(polymer: var string) =
  var pos = 0
  while pos < polymer.high:
    if abs(polymer[pos].ord - polymer[pos+1].ord) == 32:
      polymer.delete(pos, pos+1)
      pos -= 2
    pos += 1
    if pos < 0: pos = 0

let polymer = readFile("input.txt").strip()

var shortestPolymer = int.high
for letter in {'A'..'Z'}:
  var shortenedPolymer = polymer.multiReplace(($letter, ""), ($letter.toLowerASCII, ""))
  reactPolymer(shortenedPolymer)
  if shortenedPolymer.len < shortestPolymer:
    shortestPolymer = shortenedPolymer.len

echo shortestPolymer
