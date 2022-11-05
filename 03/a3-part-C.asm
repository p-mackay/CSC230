# This code assumes the use of the "Bitmap Display" tool.
#
# Tool settings must be:
#   Unit Width in Pixels: 32
#   Unit Height in Pixels: 32
#   Display Width in Pixels: 512
#   Display Height in Pixels: 512
#   Based Address for display: 0x10010000 (static data)
#
# In effect, this produces a bitmap display of 16x16 pixels.


	.include "bitmap-routines.asm"

	.data
TELL_TALE:
	.word 0x12345678 0x9abcdef0	# Helps us visually detect where our part starts in .data section
	
	.globl main
	.text	
main:
	addi $a0, $zero, 0 	#row
	addi $a1, $zero, 0		#column
	addi $a2, $zero, 0x00ff0000	#color
	jal draw_bitmap_box
	
	addi $a0, $zero, 11 	#row
	addi $a1, $zero, 6		#column
	addi $a2, $zero, 0x00ffff00	#color
	jal draw_bitmap_box
	
	addi $a0, $zero, 8 		#row
	addi $a1, $zero, 8		#column
	addi $a2, $zero, 0x0099ff33	#color
	jal draw_bitmap_box
	
	addi $a0, $zero, 2 		#row
	addi $a1, $zero, 3		#column
	addi $a2, $zero, 0x00000000	#color
	jal draw_bitmap_box

	addi $v0, $zero, 10
	syscall
	
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv


# Draws a 4x4 pixel box in the "Bitmap Display" tool
# $a0: row of box's upper-left corner
# $a1: column of box's upper-left corner
# $a2: colour of box

draw_bitmap_box:

	addi $sp, $sp, -16
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	
	add $s0, $zero, $a0
	add $s1, $zero, $a1 
	add $s2, $zero, $a2
	addi $s3, $zero, 4		#column counter
	addi $s4, $zero, 4		#row counter
	
outer_loop:	#column
	addi $s3, $s3, -1

inner_loop:	
	addi $s4, $s4, -1
	jal set_pixel
	addi $a0, $a0, 1
	bne $s4, $zero, inner_loop
	
	add $a0, $zero, $s0
	add $s4, $s4, 4
	addi $a1, $a1, 1
	bne $s3, $zero, outer_loop
		
exit:
	
	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	addi $sp, $sp, 16
	
	jr $ra

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE
