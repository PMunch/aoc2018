import strutils

var
  polymer = readFile("input.txt").strip()
  pos = 0

while pos < polymer.high:
  if abs(polymer[pos].ord - polymer[pos+1].ord) == 32:
    polymer.delete(pos, pos+1)
    pos -= 2
  pos += 1
  if pos < 0: pos = 0

echo polymer.len
