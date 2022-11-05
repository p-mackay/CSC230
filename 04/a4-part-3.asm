	.include "display.asm"
	.data
	
GEN_A:	.space 256
GEN_B:	.space 256
GEN_Z:	.space 256


# Students may modify the ".data" and "main" section temporarily
# for their testing. However, when evaluating your submission, all
# code from lines 1 to 33 will be replaced by other testing code
# (i.e., we will only keep code from lines 34 onward). If your
# solution breaks because you have ignored this note, then a mark
# of zero for Part 3 of the assignment is possible.

TEST_PATTERN:
	.word   0x0000 0x0000 0x0ff8 0x1004 0x0000 0x0630 0x0000 0x0080
        	0x0080 0x2002 0x1004 0x0808 0x0630 0x01c0 0x0000 0x0000

		
	.text
main:
	la $a0, GEN_A
	la $a1, TEST_PATTERN
	jal bitmap_to_16x16
	
	la $a0, GEN_A
	jal draw_16x16
			
	addi $v0, $zero, 10
	syscall
	

# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	.data
	
# Available for any extra `.eqv` or data needed for your solution.

	.text
	

# bitmap_to_16x16:
#	
# $a0 is destination 16x16 byte array
# $a1 is the start address of the pattern as encoded in a 16-word
#     sequence of row bitmaps.
#
# $v0 holds the value of the bytes around the row and column
# 
# Please see the assignment description for more
# information regarding the expected behavior of
# this function.

bitmap_to_16x16:
	jr $ra
	
	
# draw_16x16:
#
# $a0 holds the start address of the 16x16 byte array 
# holding the pattern for the Bitmap Display tool.
#
# Assumption: A value of 0 at a specific row and column means
# the pixel at the row & column in the bitmap display is
# off (i.e., black). A value of 1 at a specific row and column
# means the pixel at the row & column in the bitmap display
# is on (i.e., white). All other values (i.e., 2 and greater)
# are ignored.

draw_16x16:
	jr $ra


# Use here your solution to Part B for this function
# (i.e., copy-and-paste your code).
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