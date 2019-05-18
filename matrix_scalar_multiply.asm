.data
.align 4
destMat: .space 20000


.text

matrix_scalar_multiply:

# a0
# address of first element m

# a1 col

# a2 row

# a3 scalar

# i = 0
li $t0, 0

outerLoop:

# j = 0
li $t1, 0


innerLoop:

mul $t2,$t0,$a2

add $t2, $t2, $t1

sll $t2, $t2, 2

add $t3, $t2, $a0

lw $t4, 0($t3)

mul $t4,$t4,$a3

la $t5, destMat
add $t5, $t5, $t2

sw $t4, 0($t5)

addi $t1, $t1, 1

blt $t1,$a2, innerLoop

addi $t0, $t0, 1

blt $t0, $a1, outerLoop

la $v0, destMat

jr $ra


.data
.align 4
r0:	.word  -4, 2, 1
r1:	.word  -2, 4, 3


.text
.globl main

main:
la $a0, r0
li $a1, 2
li $a2, 3
li $a3, 4
jal matrix_scalar_multiply

move $s0, $v0


lw $a0, 0($s0)
li $v0, 1
syscall

li $a0, ' '
li $v0, 11
syscall

lw $a0, 4($s0)
li $v0, 1
syscall

li $a0, ' '
li $v0, 11
syscall


lw $a0, 8($s0)
li $v0, 1
syscall

li $a0, '\n'
li $v0, 11
syscall


lw $a0, 12($s0)
li $v0, 1
syscall

li $a0, ' '
li $v0, 11
syscall

lw $a0, 16($s0)
li $v0, 1
syscall

li $a0, ' '
li $v0, 11
syscall

lw $a0, 20($s0)
li $v0, 1
syscall



