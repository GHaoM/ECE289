.data
msg_yes:    .asciiz "yes"
msg_no:     .asciiz "no"

.text
li $v0, 5
syscall
move $t0, $v0

li $v0, 5
syscall
move $t1, $v0

bgt $t0, $t1, sub1

la $a0, msg_no
li $v0, 4
syscall

j exit

sub1:
la $a0, msg_yes
li $v0, 4
syscall

exit:
li $v0, 10
syscall

