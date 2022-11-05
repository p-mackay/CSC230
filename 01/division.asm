# UVic CSC 230, Fall 2020
# Assignment #1, part C

# Student name: Paul MacKay
# Student number: V00967869


# Compute M / N, where M must be in $8, N must be in $9,
# and M / N must be in $15.
# N will never be 0


.text
start:
	#lw $8, testcase1_M
	#lw $9, testcase1_N
	lw $8, testcase2_M
	lw $9, testcase2_N
	#lw $8, testcase3_M
	#lw $9, testcase3_N


# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	li $15, 0 #counter for quotient 
loop:
	
	sub $8, $8, $9	 	#subtract $9 from $8 then store the result in $8
	blez $8, end 		#pre-condition testing for zero
	addi $15, $15, 1	#$9 was successfully subtracted from $8, count++
	bgtz $8, loop 		#if $8 is still greater than zero return to the top of the loop
	blez $8, end 		#exit when $8 is less than zero

end: nop

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE

exit:
	add $2, $0, 10
	syscall
		

.data

# testcase1: 370 / 120 = 3
#
testcase1_M:
	.word	370
testcase1_N:
	.word 	120
	
# testcase2: 24156 / 77 = 313
#
testcase2_M:
	.word	24156
testcase2_N:
	.word 	77
	
# testcase3: 33 / 120 = 0
#
testcase3_M:
	.word	33
testcase3_N:
	.word 	120
