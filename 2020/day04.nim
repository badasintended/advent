import
  os,
  re,
  sequtils,
  strformat,
  strutils,
  sugar,
  tables

var passports = @[initTable[string, string]()]

let file = open(&"{getAppDir()}/in/04")
for line in file.lines:
  if line.isEmptyOrWhitespace():
    passports.add(initTable[string, string]())
    continue
  for entry in line.split(" "):
    let split = entry.split(":")
    passports[passports.high][split[0]] = split[1]
file.close()

# first rule
var first = 0
let required = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]

# second rule
var second = 0
var checker = initTable[string, string -> bool]()
checker["cid"] = s => true
checker["byr"] = s => parseInt(s) in 1920..2002
checker["iyr"] = s => parseInt(s) in 2010..2020
checker["eyr"] = s => parseInt(s) in 2020..2030
checker["hcl"] = s => s[0] == '#' and s.len == 7 and s.substr(1).match(re(r"[0-9a-f]"))
checker["ecl"] = s => s in ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
checker["pid"] = s => s.len == 9 and s.all(c => c.isDigit())
checker["hgt"] = proc (s: string): bool =
  if s.endsWith("cm") or s.endsWith("in"):
    let last = s.substr(s.len - 2)
    let num = parseInt(s.substr(0, s.len - 3))
    if last == "cm":
      result = num in 150..193
    elif last == "in":
      result = num in 59..76

for pass in passports:
  if required.all(x => pass.hasKey(x)):
    first.inc()

    var valid = true
    for k, v in pass.pairs:
      valid = valid and checker[k](v)
    if valid:
      second.inc()

echo(&"first : {first}")
echo(&"second: {second}")
