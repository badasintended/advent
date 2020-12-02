import math
import os
import strformat
import strutils

let file = open(fmt"{getAppDir()}/in/01")
var numbers = newSeq[int]()
for line in file.lines:
  numbers.add(parseInt(line))
file.close()

var finished = false

proc find2020(iter: int, o: var seq[int]) =
  if finished:
    return
  if iter == 0:
    if sum(o) == 2020:
      echo(fmt"the {o.len} numbers is {o}, the answer is {prod(o)}")
      finished = true
  else:
    var i = iter
    dec(i)
    for n in numbers:
      o[i] = n
      find2020(i, o)

proc find2020(iter: int) =
  var s = newSeq[int](iter)

  finished = false
  find2020(iter, s)

find2020(2)
find2020(3)
