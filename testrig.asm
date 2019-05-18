# Warren's test rig for Assignment 2.
# Copy your code at the bottom and then load this
# into MARS and run it to stress-test your answer.
#
# If you think the code looks ugly, that's because I
# am using a macro assembler to create the printing code.
#
	.data
str1:	.asciiz "Malloc "
str10:	.asciiz "Strcmp string2 string1 gives "
str11:	.asciiz "Strcmp string1 string1 gives "
str12:	.asciiz "Strcmp string1 string3 gives "
str13:	.asciiz "Strcmp string3 string1 gives "
str14:	.asciiz "Strcmp NULL string3 gives "
str15:	.asciiz "Strcmp string1 NULL gives "
str16:	.asciiz "Memcpy string1 buf1 gives "
str17:	.asciiz "Memcpy string1 buf2 gives "
str18:	.asciiz "Memcpy overlap buf3 buf4 gives "
str19:	.asciiz "Memcpy overlap buf7 into buf6 gives "
str2:	.asciiz " gives "
str20:	.asciiz "Memcpy overlap buf7 into buf6 size 0 gives "
str21:	.asciiz "Memcpy overlap buf7 into buf6 size -5 gives "
str22:	.asciiz "Strdup string1 gives "
str23:	.asciiz "Strdup string3 gives "
str24:	.asciiz "Strdup empty string gives "
str25:	.asciiz "Strdup NULL pointer gives "
str3:	.asciiz "\n"
str4:	.asciiz "Malloc 0 gives "
str5:	.asciiz "Malloc -27 gives "
str6:	.asciiz "Strlen "
str7:	.asciiz " is "
str8:	.asciiz "Strlen on NULL is "
str9:	.asciiz "Strcmp string1 string2 gives "
#
# The following strings and buffers are used to
# test the functions.
#
line1:	.asciiz	"strlen test string #1"
line2:	.asciiz	""

buf1:	.space 30
string1: .asciiz "abcdefghijklmnopq"
string2: .asciiz "abcdefahijklmnopq"
string3: .asciiz "abcd"
buf2:	.space 30

# Some overlapping buffers
# We can copy buf3 into buf4 size 16

buf3:	.ascii	"0123456789"
buf4:	.asciiz  "abcde"
buf5:	.space	10

# We can copy buf7 into buf6 size 11
buf6:	.ascii  "abcde"
buf7:	.asciiz	"0123456789"

# The test rig code
	.text
main:
	# Do 20 mallocs, using $t7 as a counter
	li $t7, 20
malloop1:
	# Do a malloc of size $t7 and get the result into $t0
	# Each malloc should return a pointer to a new buffer
	# of at least $t7's value in size. More likely, the
	# return value will be bumped up to a multiple of 4.
	move $a0, $t7
	jal malloc

	# Now print the result
	move $t0, $v0
	la $a0, str1
	li $v0, 4
	syscall
	move $a0, $t7
	li $v0, 1
	syscall
	la $a0, str2
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall
	sub $t7, $t7, 1			# Decrement the counter
	bnez $t7, malloop1		# and loop backwards

	# Now do a zero sized malloc. This must not crash.
	# Question: what do you think it should return?
	li $a0, 0
	jal malloc
	move $t0, $v0
	la $a0, str4
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	# Now a negative sized malloc. This must not crash.
	# Question: what do you think it should return?
	li $a0, -27
	jal malloc
	move $t0, $v0
	la $a0, str5
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	# Time to move on to testing strlen()
strlentest:
        # Test strlen() using line1
        la $a0, line1
        jal strlen
        move $t0, $v0
        la $t1, line1
	la $a0, str6
	li $v0, 4
	syscall
	move $a0, $t1
	li $v0, 4
	syscall
	la $a0, str7
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	# Test strlen() with an empty line
        la $a0, line2
        jal strlen
        move $t0, $v0
        la $t1, line2
	la $a0, str6
	li $v0, 4
	syscall
	move $a0, $t1
	li $v0, 4
	syscall
	la $a0, str7
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	# strlen() test with NULL pointer
        la $a0, 0
        jal strlen
        move $t0, $v0
	la $a0, str8
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall

strcmptest:
	# Test strcmp(). string2 comes before string1
	la $a0, string1
	la $a1, string2
	jal strcmp
        move $t0, $v0
	la $a0, str9
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	# Test strcmp(). string2 comes before string1
	la $a0, string2
	la $a1, string1
	jal strcmp
        move $t0, $v0
	la $a0, str10
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	# Test strcmp() with two equal strings
	la $a0, string1
	la $a1, string1
	jal strcmp
        move $t0, $v0
	la $a0, str11
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	# Test strcmp() with different sized strings
	la $a0, string1
	la $a1, string3
	jal strcmp
        move $t0, $v0
	la $a0, str12
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	# Test strcmp() with different sized strings
	la $a0, string3
	la $a1, string1
	jal strcmp
        move $t0, $v0
	la $a0, str13
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall
	
	# Test strcmp() with a NULL string
	la $a0, 0
	la $a1, string3
	jal strcmp
        move $t0, $v0
	la $a0, str14
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall
	
	# Test strcmp() with a NULL string
	la $a0, string1
	la $a1, 0
	jal strcmp
        move $t0, $v0
	la $a0, str15
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall

copytest:
	# Onto the memcpy() testing
        # Copy string1 into the buffer1, not overlapping
        la $a0, buf1
        la $a1, string1
        li $a2, 18
        jal memcpy
        move $t0, $v0
	la $a0, str16
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 4
	syscall
	la $a0, str3
	li $v0, 4
	syscall

        # Copy string1 into the buffer2, not overlapping
        la $a0, buf2
        la $a1, string1
        li $a2, 18
        jal memcpy
        move $t0, $v0
	la $a0, str17
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 4
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	# Copy overlapping buffers: buf3 and buf4 into buf4
        la $a0, buf4
        la $a1, buf3
        li $a2, 16
        jal memcpy
        move $t0, $v0
	la $a0, str18
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 4
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	# Copy overlapping buffers: buf7 into buf6 size 11
        la $a0, buf6
        la $a1, buf7
        li $a2, 11
        jal memcpy
        move $t0, $v0
	la $a0, str19
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 4
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	# Do a copy size 0 which is pointless
        la $a0, buf6
        la $a1, buf7
        li $a2, 0
        jal memcpy
        move $t0, $v0
	la $a0, str20
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 4
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	# Do a copy size -5 which is pointless
        la $a0, buf6
        la $a1, buf7
        li $a2, -5
        jal memcpy
        move $t0, $v0
	la $a0, str21
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 4
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	# Now some strdup testing!
duptest:
	la $a0, string1
	jal strdup
        move $t0, $v0
	la $a0, str22
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 4
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	la $a0, string3
	jal strdup
        move $t0, $v0
	la $a0, str23
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 4
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	la $a0, line2
	jal strdup
        move $t0, $v0
	la $a0, str24
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 4
	syscall
	la $a0, str3
	li $v0, 4
	syscall

	la $a0, 0
	jal strdup
        move $t0, $v0
	la $a0, str25
	li $v0, 4
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	la $a0, str3
	li $v0, 4
	syscall

end:
        li $v0, 10                      # Exit the program with syscall 10
        syscall
