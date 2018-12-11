import sequtils, strutils, tables, algorithm

type
  Node = ref object
    name: char
    before: seq[Node]
    after: seq[Node]

var nodes = initTable[char, Node]()
for line in lines("input.txt"):
  let
    before = line[5]
    after = line[36]

  if not nodes.hasKey(before):
    nodes[before] = Node(name: before, before: @[], after: @[])
  if not nodes.hasKey(after):
    nodes[after] = Node(name: after, before: @[], after: @[])
  nodes[before].after.add nodes[after]
  nodes[after].before.add nodes[before]

var options: seq[Node]
for node in nodes.values:
  if node.before.len == 0:
    options.add node

while options.len != 0:
  options.sort(proc (a, b: Node): int = system.cmp(b.name, a.name))
  let node = options.pop()
  stdout.write(node.name)
  for after in node.after:
    after.before.keepIf(proc (x: Node): bool = x.name != node.name)
    if after.before.len == 0:
      options.add(after)
stdout.write("\n")
