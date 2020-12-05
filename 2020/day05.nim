import 
  algorithm,
  elvis,
  os,
  sequtils,
  strformat,
  strutils

proc parseId(s: string): int =
  var m = s;
  for i, c in m.mpairs:
    c = c in "BR" ? '1' ! '0'
  result = parseBinInt(m[0..6]) * 8 + parseBinInt(m[7..9])

let ids = open(&"{getAppDir()}/in/05")
  .readAll()
  .splitLines()
  .map(parseId)

var second = 0

for i in 1..126:
  for j in 0..7:
    let id = i * 8 + j
    if id notin ids and id+1 in ids and id-1 in ids:
      second = id

echo(&"first : {ids.sorted().reversed()[0]}")
echo(&"second: {second}")
