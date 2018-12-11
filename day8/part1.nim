import strutils, sequtils

let
  data = readFile("input.txt")
  numbers = data.strip.split.map(parseInt)

var metadata = 0

#let nodes = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
#var cnode = 0
proc parseNode(pos: int): int =
  let
    children = numbers[pos]
    meta = numbers[pos + 1]
  #echo nodes[cnode], ": ", children, ", ", meta
  #cnode += 1
  result = 2
  for child in 0..<children:
    result += parseNode(pos+result)
  for num in 0..<meta:
    metadata += numbers[pos+result]
    result += 1

assert parseNode(0) == numbers.len
echo metadata

