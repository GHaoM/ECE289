
.text

popCnt:

# input
move $t0, $a0

# sum = 0
li $t1, 0

# i = 0
li $t2, 0

popCntForLoop:

andi $t3, $t0, 1

# sum += (input) & 1;
add $t1, $t1, $t3

li $t3, 2
div $t0,$t0,$t3

addi $t2, $t2, 1

blt $t2, 32, popCntForLoop

move $v0, $t1

jr $ra

.text
.globl main

main:
li $a0, 863
jal popCnt
move $a0, $v0
li $v0, 1
syscall





