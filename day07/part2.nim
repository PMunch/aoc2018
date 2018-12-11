import sequtils, strutils, tables, algorithm

type
  Node = ref object
    name: char
    before: seq[Node]
    after: seq[Node]
  Worker = object
    node: char
    timeLeft: int

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

var workers: seq[Worker]
workers.setLen(5)
var
  step = 0
  #done = ""
while options.len != 0 or workers.filter(proc (x: Worker): bool = x.node != '\0').len != 0:
  #echo "step ", step, ", done parts: ", done
  for worker in workers.mitems:
    worker.timeLeft -= 1
    if worker.timeLeft <= 0:
      if worker.node != '\0':
        #done &= worker.node
        for after in nodes[worker.node].after:
          after.before.keepIf(proc (x: Node): bool = x.name != worker.node)
          if after.before.len == 0:
            options.add(after)
      worker.node = '\0'
  options.sort(proc (a, b: Node): int = system.cmp(b.name, a.name))
  for worker in workers.mitems:
    if worker.node == '\0' and options.len != 0:
      let node = options.pop()
      worker.node = node.name
      worker.timeLeft = 60 + ord(node.name) - 64
    #echo "Worker working on ", worker.node, " with ", worker.timeLeft, " time left"
  step += 1
#echo "step ", step - 1, ", done parts: ", done
echo step - 1
