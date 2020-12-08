import 
  elvis,
  os,
  sequtils,
  strformat,
  strutils,
  sugar,
  tables

proc parseInstruction(line: string): tuple[opr: string, arg: int] =
  let arr = line.split(" ")
  result = (arr[0], parseInt(arr[1]))

var instructions = open(&"{getAppDir()}/in/08")
  .readAll()
  .splitLines()
  .map(parseInstruction)

var acc = 0
var ran: seq[int]

var ops = initTable[string, (int, int) -> int]()
ops["nop"] = (line, arg) => line + 1
ops["jmp"] = (line, arg) => line + arg
ops["acc"] = proc (line: int, arg: int): int =
  acc += arg
  result = line + 1

proc run(line: int) =
  if (line notin ran):
    ran.add(line)
    let ins = instructions[line]
    let res = ops[ins.opr](line, ins.arg)
    echo res
    run(res)

run(0)
echo &"first : {acc}"

for i, ins in instructions.mpairs:
  let prev = ins.opr
  if prev in ["nop", "jmp"]:
    ins.opr = prev == "nop" ? "jmp" ! "nop"
    acc = 0
    ran = newSeq[int]()
    try: run(0) except: discard
    ins.opr = prev
    if ran.len == instructions.len:
      break

echo &"second: {acc}"
