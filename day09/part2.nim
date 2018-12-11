import strutils, times, lists

let
  input = readFile("input.txt").split()
  numPlayers = input[0].parseInt
  lastMarble = input[6].parseInt*100
var
  marbles = initDoublyLinkedRing[int]()
  players = newSeq[int](numPlayers)
  currentPlayer = 0
  longestDuration = 0.0
marbles.append(0)

for marble in 1..lastMarble:
  if marble mod 23 == 0:
    players[currentPlayer] += marble
    var removeMarble = marbles.head.prev
    for i in 0..<7:
      removeMarble = removeMarble.prev
    players[currentPlayer] += removeMarble.value
    marbles.head = removeMarble.next.next
    marbles.remove removeMarble
  else:
    marbles.head = marbles.head.next
    marbles.prepend(marble)
    marbles.head = marbles.head.next
  currentPlayer = (currentPlayer + 1) mod numPlayers
var highestScore = 0
for score in players:
  if score > highestScore:
    highestScore = score

echo highestScore

