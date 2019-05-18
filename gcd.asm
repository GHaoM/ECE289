
.text

gcd:

# u
move $t0, $a0

# v
move $t1, $a1

beqz $t0, gcd_return
beqz $t1, gcd_return

# shift = 0
li $t2, 0

gcd_for_loop:

or $t3, $t0, $t1
andi $t3, $t3, 1
bne $t3, $zero, gcd_for_loop_out

srl $t0, $t0, 1
srl $t1, $t1, 1

addi $t2, $t2, 1
j gcd_for_loop

gcd_for_loop_out:

gcd_while_loop:
andi $t3, $t0, 1
bne $t3, $zero, gcd_while_loop_out
srl $t0, $t0, 1
j gcd_while_loop

gcd_while_loop_out:

gcd_do_loop:


v_gcd_while_loop:
andi $t3, $t1, 1
bne $t3, $zero, v_gcd_while_loop_out
srl $t1, $t1, 1
j v_gcd_while_loop

v_gcd_while_loop_out:

bgt $t0, $t1, elseBranch

sub $t1, $t1, $t0
j contBranch

elseBranch:

sub $t4, $t0, $t1
move $t0, $t1
move $t1, $t4

contBranch:
srl $t1, $t1, 1

beqz $t1, gcd_do_loop_out

j gcd_do_loop

gcd_do_loop_out:

sllv $v0, $t0, $t2
j gcd_exit

gcd_return:
or $v0, $t0, $t1


j gcd_exit


gcd_exit:

jr $ra



.text
.globl main

main:
li $a0, 24
li $a1, 36
jal gcd
move $a0, $v0
li $v0, 1
syscall









