import strutils, sets, times

var totalElapsed: float
for i in 0..99:
  let startTime = cpuTime()
  var
    polymer = cast[seq[int8]](readFile("input.txt").strip())
    pos_low = 0
    pos_high = 1
    deleted = 0

  while pos_high <= polymer.high:
    pos_low = pos_high - 1
    while (polymer[pos_low] and 0x80) == 0x80:
      pos_low -= (polymer[pos_low] and 0x7f).int
    if (polymer[pos_low] xor polymer[pos_high]) == 32:
      polymer[pos_low] = cast[int8](0x80 or 1)
      if pos_low > 0 and (polymer[pos_low - 1] and 0x80) == 0x80:
        if (polymer[pos_low - 1] and 0x74) + pos_high - pos_low + 1 > 127:
          polymer[pos_high] = cast[int8](0xff)
        else:
          polymer[pos_high] = cast[int8](((polymer[pos_low - 1] and 0x74) + pos_high - pos_low + 1).uint8 or 0x80)
      elif pos_high - pos_low + 1 > 127:
        polymer[pos_high] = cast[int8](0xff)
      else:
        polymer[pos_high] = cast[int8]((pos_high - pos_low + 1).uint8 or 0x80)
      deleted += 2
    pos_high += 1

  let elapsedTime = cpuTime() - startTime
  #echo elapsedTime*1000
  totalElapsed += elapsedTime
echo totalElapsed * 10
#for c in polymer:
#  stdout.write(c.toHex & " ")
#stdout.write("\n")
