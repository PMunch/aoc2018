import strutils

var fabric: array[0..1000, array[0..1000, int]]

template parseLines(file: string, body: untyped): untyped {.dirty.} =
  for line in lines(file):
    let
      fields = line.split
      id = fields[0][1..^1]
      pos = fields[2][0..^2].split(',')
      size = fields[3].split('x')
      x = pos[0].parseInt
      y = pos[1].parseInt
      w = size[0].parseInt
      h = size[1].parseInt

    body

parseLines("input.txt"):
  for xc in x..<(x+w):
    for yc in y..<(y+h):
      fabric[xc][yc] += 1

parseLines("input.txt"):
  var overlapping = false
  for xc in x..<(x+w):
    for yc in y..<(y+h):
      if fabric[xc][yc] > 1:
        overlapping = true
  if not overlapping:
    echo id
