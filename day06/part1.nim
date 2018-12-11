import strutils

var
  field: tuple[x, y, w, h: int] = (int.high, int.high, 0, 0)
  coords: seq[tuple[pos: tuple[x, y: int], score: int]]

for coord in lines("input2.txt"):
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

for x in field.x..field.w:
  for y in field.y..field.h:
    var
      shortestDist = int.high
      bestCoord: int
      tie = false
    for i, coord in coords:
      let dist = abs(x - coord.pos.x) + abs(y - coord.pos.y)
      if dist == shortestDist:
        tie = true
      if dist < shortestDist:
        tie = false
        shortestDist = dist
        bestCoord = i
    if tie == false:
      if x == field.x or x == field.w or y == field.y or y == field.h:
        coords[bestCoord].score = -1
      if coords[bestCoord].score != -1:
        coords[bestCoord].score += 1

var bestScore = 0
for coord in coords:
  echo coord
  if coord.score > bestScore:
    bestScore = coord.score

echo bestScore
