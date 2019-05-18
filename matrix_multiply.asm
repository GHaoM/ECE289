
.data
.align 4
r0:	.word  1, 2, 1
r1:	.word  2, 1, 2


x0:	.word  2, 1
x1:	.word  3, -1
x3:	.word  2, -2

desMat: .space 2000

.text

matrix_multiply:

# mrow  a0
# mcol a1
# nrow a2
# ncol a3

la $v0, desMat

la $t5, r0

la $t6, x0

bne $a1, $a2, matrix_multiply_exit

# i = 0
li $t0, 0

outLoop:

# j = 0
li $t1, 0

midLoop:

# k = 0
li $t2, 0

li $t3, 0
innerLoop:

mul $t4,$t2,$a1
add $t4, $t4, $t1
sll $t4, $t4, 2
add $t4, $t4, $t5

lw $t7, 0($t4)

mul $t4,$t0,$a3
add $t4, $t4, $t2
sll $t4, $t4, 2
add $t4, $t4, $t6

lw $t8 0($t4)

mul $t7,$t7,$t8

add $t3, $t3, $t7

addi $t2, $t2, 1

blt $t2, $a1, innerLoop

mul $t4,$t0,$a3
add $t4, $t4, $t1
sll $t4, $t4, 2
add $t4, $t4, $v0

sw $t3, 0($t4)

addi $t1, $t1, 1

blt $t1, $a3, midLoop

addi $t0, $t0, 1

blt $t0, $a0, outLoop

matrix_multiply_exit:

jr $ra


.text
.globl main

main:

li $a0, 2
li $a1, 3
li $a2, 3
li $a3, 2
jal matrix_multiply

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

li $a0, '\n'
li $v0, 11
syscall


lw $a0, 8($s0)
li $v0, 1
syscall

li $a0, ' '
li $v0, 11
syscall

lw $a0, 12($s0)
li $v0, 1
syscall


