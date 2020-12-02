import os
import strformat
import strutils

type
  Password = object
    a, b: int
    c, t: string

proc newPassword(input: string): Password =
  let s = input.split({'-', ' ', ':'})
  result = Password(
    a: parseInt(s[0]),
    b: parseInt(s[1]),
    c: s[2],
    t: s[4]
  )
  #echo result

var passwords: seq[Password]

let file = open(&"{getAppDir()}/in/02")
for line in file.lines:
  passwords.add(newPassword(line))
file.close()

var one = 0
var two = 0

for pw in passwords:
  # first
  let occ = pw.t.count(pw.c)
  if pw.a <= occ and occ <= pw.b:
    one.inc()
    #echo(&"t: {pw.t}, c: {pw.c}, {pw.a} <= {occ} <= {pw.b}")

  # second
  let a = pw.a - 1
  let b = pw.b - 1
  if pw.t[a] in pw.c xor pw.t[b] in pw.c:
    two.inc()
    #echo(&"t: {pw.t}, c: {pw.c}, {a}: {pw.t[a]}, {b}: {pw.t[b]}")
  

echo(&"first  rule: {one}")
echo(&"second rule: {two}")
