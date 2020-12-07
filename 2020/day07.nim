import
  os,
  sequtils,
  strformat,
  strutils,
  tables

var rules = initTable[string, Table[string, int]]()

proc parse(line: string) =
  var l = line[0..^2].split(" bags contain ")
  let values = l[1].split(", ")
  var inner = initTable[string, int]()
  for v in values:
    if v != "no other bags":
      let s = v.split(' ')
      inner[&"{s[1]} {s[2]}"] = parseInt(s[0])
  rules[l[0]] = inner

open(&"{getAppDir()}/in/07")
  .readAll()
  .splitLines()
  .apply(parse)

var first = 0
var already: seq[string]
proc searchFirst(key: string = "shiny gold") =
  for k, inner in rules:
    if inner.hasKey(key) and k notin already:
      inc first
      already.add(k)
      searchFirst(k)
searchFirst()

var second = 0
proc searchSecond(key: string = "shiny gold", mul: int = 1) =
  var all = 0
  for k, v in rules[key]:
    all += v
    searchSecond(k, v * mul)
  second += all * mul
searchSecond()

echo &"first : {first}"
echo &"second: {second}"
