const serialNumber = 1309

var powerCells: array[1..300, array[1..300, int]]

for x in 1..300:
  for y in 1..300:
    let rackId = x + 10
    var powerLevel = rackId * y
    powerLevel += serialNumber
    powerLevel *= rackId
    powerLevel = (powerLevel div 100) mod 10
    powerLevel -= 5
    powerCells[x][y] = powerLevel

var
  maxPowerSum = 0
  bestGrid: tuple[x, y, size: int]
for size in 1..300:
  for x in 1..(300-size):
    for y in 1..(300-size):
      var powerSum = 0
      for xx in 0..<size:
        for yy in 0..<size:
          powerSum += powerCells[x+xx][y+yy]
      if powerSum > maxPowerSum:
        maxPowerSum = powerSum
        bestGrid = (x, y, size)

echo bestGrid
echo maxPowerSum
