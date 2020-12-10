import
  algorithm,
  math,
  os,
  sequtils,
  strformat,
  strutils,
  tables

var adapters = 0 & open(&"{getAppDir()}/in/10")
  .readAll()
  .splitLines()
  .map(parseInt)
  .sorted()
let max = adapters.max + 3
adapters.add(max)

let loop = adapters[0..^2]

var first = [0, 0]
for i, a in loop:
  let r = adapters[i+1] - a
  if r == 1:
    inc first[0]
  elif r == 3:
    inc first[1]

echo first.prod()

let r = 1..3
var second = initTable[int, int]()
second[max] = 1
for i in loop.reversed():
  second[i] = 0
  for j in r:
    if i + j in second:
      second[i] += second[i+j]

echo second[0]
