import strutils

var seenBoxes: seq[string]

for line in lines("input.txt"):
  for box in seenBoxes:
    if box.editDistance(line) == 1:
      var sameLetters: string
      for i, letter in line:
        if letter == box[i]:
          sameLetters.add letter
      echo sameLetters
      quit 0
  seenBoxes.add line
quit 1
