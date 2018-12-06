import strutils

var
  fabric: array[0..1000, array[0..1000, int]]
  overlapping = 0

for line in lines("input.txt"):
  let
    fields = line.split
    pos = fields[2][0..^2].split(',')
    size = fields[3].split('x')
    x = pos[0].parseInt
    y = pos[1].parseInt
    w = size[0].parseInt
    h = size[1].parseInt

  for xc in x..<(x+w):
    for yc in y..<(y+h):
      if fabric[xc][yc] == 1:
        overlapping += 1
      fabric[xc][yc] += 1

echo overlapping

