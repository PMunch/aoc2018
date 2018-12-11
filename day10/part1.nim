import strutils

type
  Point = object
    x, y: int
    dx, dy: int
  Rect = object
    x, y: int
    w, h: int

var
  points: seq[Point]
  bounding = Rect(x: int.high, y: int.high, w: int.low, h: int.low)

for line in lines("input.txt"):
  points.add Point(
    x: line[10..15].strip.parseInt,
    y: line[18..23].strip.parseInt,
    dx: line[36..37].strip.parseInt,
    dy: line[40..41].strip.parseInt
  )
  if points[^1].x < bounding.x:
    bounding.x = points[^1].x
  if points[^1].y < bounding.y:
    bounding.y = points[^1].y
  if points[^1].x > bounding.w:
    bounding.w = points[^1].x
  if points[^1].y > bounding.h:
    bounding.h = points[^1].y

bounding.w -= bounding.x
bounding.h -= bounding.y

while true:
  var newBounding = Rect(x: int.high, y: int.high, w: int.low, h: int.low)
  for point in points.mitems:
    point.x += point.dx
    point.y += point.dy
    if point.x < newBounding.x:
      newBounding.x = point.x
    if point.y < newBounding.y:
      newBounding.y = point.y
    if point.x > newBounding.w:
      newBounding.w = point.x
    if point.y > newBounding.h:
      newBounding.h = point.y
  newBounding.w -= newBounding.x
  newBounding.h -= newBounding.y
  if bounding.w*bounding.h < newBounding.w*newBounding.h:
    echo bounding
    for point in points.mitems:
      point.x -= point.dx
      point.y -= point.dy
    break
  bounding = newBounding

for y in 0..bounding.h:
  var line = newString(bounding.w+1)
  for x in 0..bounding.w:
    for point in points:
      if point.y == bounding.y + y and point.x == bounding.x + x:
        line[x] = '#'
      elif line[x] == '\0':
        line[x] = ' '
  echo line
