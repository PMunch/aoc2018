import tables

var
  doubles = 0
  triples = 0
for line in lines("input.txt"):
  var letters = initTable[char, int]()
  for letter in line:
    if letters.hasKeyOrPut(letter, 1):
      letters[letter] += 1
  var
    double = false
    triple = false
  for count in letters.values:
    if count == 2:
      double = true
    if count == 3:
      triple = true
  doubles += (if double: 1 else: 0)
  triples += (if triple: 1 else: 0)

echo doubles * triples
