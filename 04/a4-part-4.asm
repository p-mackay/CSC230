	.include "display.asm"
	
	.data
	
GEN_A:	.space 256
GEN_B:	.space 256
GEN_Z:	.space 256

# Students may modify the ".data" and "main" section temporarily
# for their testing. However, when evaluating your submission, all
# code from lines 1 to 58 will be replaced by other testing code
# (i.e., we will only keep code from lines 59 onward). If your
# solution breaks because you have ignored this note, then a mark
# of zero for Part 4 of the assignment is possible.

PATTERN_GLIDER:
	.word   0x0000 0x0000 0x0000 0x0000 0x0000 0x0000 0x0000 0x0000
        	0x0000 0x0000 0x0000 0x0000 0x0e00 0x0200 0x0400 0x0000
        	
PATTERN_PULSAR:
	.word 	0x0000 0x0e38 0x0000 0x2142 0x2142 0x2142 0x0e38 0x0000
		0x0e38 0x2142 0x2142 0x2142 0x0000 0x0e38 0x0000 0x0000
		
PATTERN_PIPSQUIRTER:
	.word   0x0000 0x0020 0x0020 0x0000 0x0088 0x03ae 0x0431 0x0acd
        	0x0b32 0x6acc 0x6a90 0x06f0 0x0100 0x0140 0x00c0 0x0000
	
PATTERN_HONEYCOMB:
	.word   0x0000 0x0000 0x0000 0x0000 0x0000 0x0180 0x0240 0x05a0
        	0x0240 0x0180 0x0000 0x0000 0x0000 0x0000 0x0000 0x0000
       
PATTERN_EATER:
	.word   0x0000 0x0000 0x1800 0x24c0 0x2848 0x1054 0x0348 0x0240
        	0x1080 0x1f00 0x0000 0x0400 0x0a00 0x0407 0x0004 0x0002
        
	.globl main
	
	
	.text
main:
	la $a0, GEN_A
	la $a1, PATTERN_PULSAR
	jal bitmap_to_16x16		# Convert bitmap pattern...
	
	la $a0, GEN_A
	jal draw_16x16			# ... and draw it.
	
next_gen:
	jal life_next_generation	# Procedure uses 16x16 0/1 "dead/alive" data in GEN_A ...
	la $a0, GEN_A			# ... and then proceeds to draw the result ...
	jal draw_16x16
	
	addi $a0, $zero, 750		# 750 milliseconds (three-quarters of a second)
	addi $v0, $zero, 32		# sleep system call
	syscall
	
	beq $zero, $zero, next_gen	# ... over and over again. Comment out this line if
					# you just want to try life_next_generation once during testing.

	addi $v0, $zero, 10
	syscall


# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	.data
	
# Available for any extra `.eqv` or data needed for your solution.

	.text

		
# life_next_generation:
#
# This procedure HAS NO PARAMETERS.
#
# Use GEN_A as the generation to draw
#
# Use GEN_B as a scratch array to compute the
# next generation (i.e., compute the value
# of the next generation in GEN_B, and once
# completed, copy over GEN_B into GEN_A

life_next_generation:
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
	

# Use here your solution to Part B for this function
# (i.e., copy-and-paste your code).
sum_neighbours:

	jr $ra
	

# Use here your solution to Part C for this function
# (i.e., copy-and-paste your code).	
bitmap_to_16x16:

	jr $ra
	
# Use here your solution to Part C for this function
# (i.e., copy-and-paste your code).		
draw_16x16:

	jr $ra
	


# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE
