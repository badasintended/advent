import
  math,
  os,
  sets,
  sequtils,
  strformat,
  strutils,
  sugar

var first: seq[seq[char]]
first.add(newSeq[char]())

proc parseFirst(line: string) =
  if line.isEmptyOrWhitespace():
    first.add(newSeq[char]())
  else:
    first[^1].add(line)

var second: seq[seq[seq[char]]]
second.add(newSeq[seq[char]]())

proc parseSecond(line: string) =
  if line.isEmptyOrWhitespace():
    second.add(newSeq[seq[char]]())
  else:
    second[^1].add(line.toSeq())

let lines = open(&"{getAppDir()}/in/06")
  .readAll()
  .splitLines()

lines.apply(parseFirst)
lines.apply(parseSecond)

echo "first : ", first.map(s => s.toHashSet().len).sum()

echo "second: ", second.map(a => a.map(b => b.filter(c => a.all(b => b.contains(c))))[0].len).sum()
