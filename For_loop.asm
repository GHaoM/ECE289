# 1+2+3+...+1000=?
# To get the answer of equation, we need set a while loop

li $t0,1 #int a
li $t1,2 #int i


sub1:
add $t0,$t0,$t1 # a = a + i
add $t1,$t1,1   # i++

ble  $t1,1000,sub1 # if i less than 1000, back to sub1
bge $t1,1000,sub2 # if i equal or bigger than 1000, go to sub2 and exit

sub2:
move $a0, $t0 
li $v0, 1
syscall

