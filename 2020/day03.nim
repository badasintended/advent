import 
  math,
  os,
  strformat

var map: seq[string]
var w = 0
var h = 0

let file = open(&"{getAppDir()}/in/03")
for line in file.lines:
  map.add(line)
  w = line.len
file.close()
h = map.len

var x = [0, 0, 0, 0, 0]
let p = [1, 3, 5, 7, 1]

# first solution is tree[1]
var tree = [0, 0, 0, 0, 0]

for i in 0..<h:
  for j in 0..<p.len:
    if j == 4 and i mod 2 != 0:
      continue
    if map[i][x[j]] == '#':
      tree[j].inc()
    x[j] = (x[j] + p[j]) mod w
  

echo(&"tree: {tree}")
echo(&"prod: {prod(tree)}")
