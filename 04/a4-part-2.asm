	.data
	
TEST_A_16x16:
	.byte  	9 3 8 5 7 0 8 3 9 3 4 7 3 5 7 1
       		4 3 2 1 7 8 5 3 7 5 3 6 6 3 1 6
       		7 4 3 1 9 5 4 6 6 3 6 1 6 6 0 7
       		3 8 1 5 0 5 5 0 4 9 2 0 6 2 4 1
       		2 6 5 9 7 2 7 8 4 2 8 0 1 1 0 9
       		5 8 7 1 9 9 7 2 2 3 8 7 2 1 2 4
       		5 6 1 0 8 8 5 7 0 3 4 5 1 4 2 4
       		7 3 6 1 8 5 3 1 4 2 0 0 6 9 7 9
       		0 5 3 4 7 3 8 9 8 5 5 0 2 4 5 5
       		6 6 0 3 8 1 3 2 1 2 5 1 5 0 7 3
       		5 8 8 3 2 7 8 8 5 4 4 4 3 6 3 7
       		4 0 3 0 9 5 7 7 0 4 8 3 0 7 9 0
       		0 6 7 4 9 2 7 0 0 4 9 1 1 9 7 5
       		8 1 2 7 6 1 4 0 3 5 3 8 1 3 3 2
       		2 9 3 7 2 0 3 8 8 3 1 9 8 0 5 8
       		2 9 7 2 1 1 0 7 9 9 9 9 1 4 6 2
	
	.text
main:

# Students may modify this "main" section temporarily for their testing.
# However, when evaluating your submission, all code from lines 1
# to 49 will be replaced by other testing code (i.e., we will only
# keep code from lines 50 onward). If your solution breaks because
# you have ignored this note, then a mark of zero for Part 2
# of the assignment is possible.

	la $a0, TEST_A_16x16
	addi $a1, $zero, 4
	addi $a2, $zero, 0
	jal sum_neighbours		# Test 2a; $v0 should be 30
	
	la $a0, TEST_A_16x16
	addi $a1, $zero, 9
	addi $a2, $zero, 8
	jal sum_neighbours		# Test 2b; $v0 should be 43
	
	la $a0, TEST_A_16x16
	addi $a1, $zero, 15
	addi $a2, $zero, 15
	jal sum_neighbours		# Test 2c; $v0 should be 19
			
	addi $v0, $zero, 10
	syscall


# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	.data
	
# Available for any extra `.eqv` or data needed for your solution.

	.text
	
	
# sum_neighbours:
#
# $a0 is 16x16 byte array
# $a1 is row (0 is topmost)
# $a2 is column (0 is leftmost)
#
# $v0 holds the value of the bytes around the row and column
sum_neighbours:

	jr $ra
	
	
# Use here your solution to Part A for this function
# (i.e., copy-and-paste your code).
set_16x16:

	jr $ra
	
	
# Use here your solution to Part A for this function
# (i.e., copy-and-paste your code).
get_16x16:

	jr $ra
	

# Use here your solution to Part A for this function
# (i.e., copy-and-paste your code).
copy_16x16:

	jr $ra


# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE
