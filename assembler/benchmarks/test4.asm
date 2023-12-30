addi a2 zero 5
addi a3 zero 7
jal x1 4
beq zero zero 14
slt t0 a2 a3
nop
nop
nop
bne t0 zero 6
add a0 zero a2
beq zero zero 4
add a0 zero a3
jalr x0 0(x1)
addi x3 x3 33
