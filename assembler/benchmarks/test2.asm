addi x5 x5 5
addi x6 zero 0
nop
nop
sw x5 0(x6)
sw x5 4(x6)
sw x5 8(x6)
sw x5 12(x6)
lw x7 0(x6)
addi x7 x7 1
lw x8 4(x6)
addi x8 x8 2
lw x9 8(x6)
addi x9 x9 3
lw x10 12(x6)
addi x10 x10 4
