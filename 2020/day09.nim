import 
  math,
  os,
  sequtils,
  strformat,
  strutils,
  sugar

let numbers = open(&"{getAppDir()}/in/09")
  .readAll()
  .splitLines()
  .map(parseInt)

block one:
  for i, num in numbers[25..^1]:
    let prev = numbers[i..i+25]
    if not prev.any(a => prev.any(b => (a != b) and (a + b == num))):
      echo &"first : {num}"
      let clamped = numbers.filterIt(it < num)
      block two:
        for i in 0..<clamped.len:
          for j in i..<clamped.len:
            let s = clamped[i..j]
            if s.sum() == num:
              echo &"second: {s.min + s.max}"
              break two
      break one
