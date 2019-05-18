.data

resultStr: .space 2000


.text 

convert_long_to_bit_string:

la $v0, resultStr

# i = num_bits - 1
addi $t0, $a1, -1

# mask = 1
li $t1, 1

forLoop:

blt $t0,$zero,forLoopOut

and $t2, $t1, $a0

ble $t2,$zero,else
add $t3, $t0, $v0
li $t4, '1'
sb $t4, 0($t3)

j forcont

else:
add $t3, $t0, $v0
li $t4, '0'
sb $t4, 0($t3)

forcont:
addi $t0, $t0, -1
sll $t1, $t1, 1
j forLoop

forLoopOut:

add $t3, $a1, $v0
li $t4, '\0'
sb $t4, 0($t3)

jr $ra



.text
.globl main

main:
li $a0, 20
li $a1, 5
jal convert_long_to_bit_string
move $a0, $v0
li $v0, 4
syscall


