import algorithm, strutils, sequtils, tables

var
  guards = initTable[string, tuple[sleepMinutes: int, naps: seq[tuple[start, stop: int]]]]()
  currentGuard: string
  sleepMinutes: int
  naps: seq[tuple[start, stop: int]]
  records = readFile("input.txt").splitLines
sort(records, system.cmp)

for record in records:
  if record.len > 19:
    let fields = record[19..^1].split
    case fields[0]:
    of "Guard":
      if currentGuard != "":
        if not guards.hasKey(currentGuard):
          guards[currentGuard] = (sleepMinutes: sleepMinutes, naps: naps)
        else:
          guards[currentGuard] = (sleepMinutes: guards[currentGuard].sleepMinutes + sleepMinutes, naps: guards[currentGuard].naps.concat naps)
        sleepMinutes = 0
        naps = @[]
      currentGuard = fields[1][1..^1]
    of "wakes":
      naps[^1].stop = record[15..16].parseInt
      sleepMinutes += naps[^1].stop - naps[^1].start
    of "falls":
      naps.add (start: parseInt(record[15..16]), stop: 0)

guards[currentGuard] = (sleepMinutes: sleepMinutes, naps: naps)
sleepMinutes = 0
naps = @[]

var
  maxSleep = 0
  deepestSleeper: string

for guard, info in guards.pairs:
  if info.sleepMinutes > maxSleep:
    deepestSleeper = guard
    maxSleep = info.sleepMinutes

var sleep: array[0..59, int]
for nap in guards[deepestSleeper].naps:
  for minute in nap.start..<nap.stop:
    sleep[minute] += 1

var
  sleepiestMinute = -1
  mostSlept = 0

for minute, sleepTime in sleep:
  if sleepTime > mostSlept:
    mostSlept = sleepTime
    sleepiestMinute = minute

echo parseInt(deepestSleeper) * sleepiestMinute
