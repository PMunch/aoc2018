import strutils, sequtils

let
  data = readFile("input.txt")
  numbers = data.strip.split.map(parseInt)

proc parseNode(pos: int): tuple[read, value: int] =
  let
    children = numbers[pos]
    meta = numbers[pos + 1]
  result.read = 2
  var childNodes: seq[tuple[read, value: int]]
  for child in 0..<children:
    childNodes.add parseNode(pos+result.read)
    result.read += childNodes[^1].read

  for num in 0..<meta:
    let metadata = numbers[pos+result.read]
    result.read += 1
    if childNodes.len == 0:
      result.value += metadata
    else:
      if metadata - 1 in 0..childNodes.high:
        result.value += childNodes[metadata - 1].value

let license = parseNode(0)
assert license.read == numbers.len
echo license.value

