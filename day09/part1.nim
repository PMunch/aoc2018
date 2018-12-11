import strutils

let
  input = readFile("input.txt").split()
  numPlayers = input[0].parseInt
  lastMarble = input[6].parseInt
var
  currentMarble = 0
  marbles = @[0]
  players = newSeq[int](numPlayers)
  currentPlayer = 0

for marble in 1..lastMarble:
  if marble mod 23 == 0:
    players[currentPlayer] += marble
    var removeMarble = currentMarble - 7
    if removeMarble < 0: removeMarble += marbles.len
    players[currentPlayer] += marbles[removeMarble]
    marbles.delete(removeMarble)
    currentMarble = removeMarble mod marbles.len
  else:
    var newPos = (currentMarble + 2)
    if newPos > marbles.len:
      newPos -= marbles.len
    marbles.insert(marble, newPos)
    currentMarble = newPos
  currentPlayer = (currentPlayer + 1) mod numPlayers
  #echo marbles
  #echo players
var highestScore = 0
for score in players:
  if score > highestScore:
    highestScore = score

echo highestScore

