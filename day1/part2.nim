import strutils, sets

var
  frequency = 0
  seenFrequencies = initSet[int]()

seenFrequencies.incl frequency

while true:
  for line in lines("input.txt"):
    if line[0] == '+':
      frequency += line[1..^1].parseInt
    else:
      frequency -= line[1..^1].parseInt
    if seenFrequencies.contains frequency:
      echo frequency
      quit 0
    else:
      seenFrequencies.incl frequency

quit 1
