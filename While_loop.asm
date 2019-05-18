# how many 7 in 30?

li $t0,0        # int i=0; using for counter
li $t1,145       # int s=30;
li $t2,-7       # int d=7

#no subtraction in MIPS, we use addi to add a negative number
#to realize the subtraction!

loop:
add $t1,$t1,$t2 # s1=s+d;
bge $t1,7,counter
blt $t1,7,exit

counter:
add $t0,$t0,1
j loop

exit:
move $a0,$t0    # print out
li $v0,1
syscall
