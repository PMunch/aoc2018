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
  bestGrid: tuple[x, y: int]
for x in 1..(300-3):
  for y in 1..(300-3):
    var powerSum = 0
    for xx in 0..2:
      for yy in 0..2:
        powerSum += powerCells[x+xx][y+yy]
    if powerSum > maxPowerSum:
      maxPowerSum = powerSum
      bestGrid = (x, y)

echo bestGrid
echo maxPowerSum
