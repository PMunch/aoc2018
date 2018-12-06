import strutils

var
  field: tuple[x, y, w, h: int] = (int.high, int.high, 0, 0)
  coords: seq[tuple[pos: tuple[x, y: int], score: int]]

for coord in lines("input.txt"):
  let
    split = coord.split(',')
    coord = (x: split[0].parseInt, y: split[1].strip.parseInt)

  if coord.x < field.x:
    field.x = coord.x
  if coord.y < field.y:
    field.y = coord.y
  if coord.x > field.w:
    field.w = coord.x
  if coord.y > field.h:
    field.h = coord.y
  coords.add (pos: coord, score: 0)

var regionSize = 0
for x in field.x..field.w:
  for y in field.y..field.h:
    var curSum = 0
    for i, coord in coords:
      let dist = abs(x - coord.pos.x) + abs(y - coord.pos.y)
      curSum += dist
    if curSum < 10_000:
      regionSize += 1

echo regionSize
