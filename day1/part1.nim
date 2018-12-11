import strutils

var frequency = 0

for line in lines("input.txt"):
  if line[0] == '+':
    frequency += line[1..^1].parseInt
  else:
    frequency -= line[1..^1].parseInt

echo frequency
