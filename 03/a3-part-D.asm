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
KEYBOARD_EVENT_PENDING:
	.word	0x0
KEYBOARD_EVENT:
	.word   0x0
BOX_ROW:
	.word	0x0
BOX_COLUMN:
	.word	0x0

	.eqv LETTER_a 97
	.eqv LETTER_d 100
	.eqv LETTER_w 119
	.eqv LETTER_x 120
	.eqv BOX_COLOUR 0x0099ff33
	
	.globl main
	
	.text	
main:
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	la $s0, 0xffff0000		# control register for MMIO Simulator "Receiver"
	lb $s1, 0($s0)
	ori $s1, $s1, 0x02		# Set bit 1 to enable "Receiver" interrupts (i.e., keyboard)
	sb $s1, 0($s0)
	
	lw $a0, BOX_ROW
	lw $a1, BOX_COLUMN	
	li $a2, 0x0099ff33
	jal draw_bitmap_box		 #draw initial box
	
	li $s0, 0
	sb $s0, KEYBOARD_EVENT_PENDING 	
	
check_for_event:			#what ascii value was entered?

	lbu $s0, KEYBOARD_EVENT_PENDING
	beq $s0, $zero, check_for_event
	
	lbu $s1, KEYBOARD_EVENT
	
	beq $s1, 97, a_pressed	#check the following
	beq $s1, 100, d_pressed
	beq $s1, 119, w_pressed
	beq $s1, 120, x_pressed
	
	sb $zero, KEYBOARD_EVENT_PENDING
	beq $zero, $zero, check_for_event
	
	
a_pressed:
	lw $a0, BOX_ROW
	lw $a1, BOX_COLUMN
	li $a2, 0x00000000
	jal draw_bitmap_box
	
	lw $s2, BOX_COLUMN
	addi, $s2, $s2, -1		#a_pressed change column coordinate one left
	sw $s2, BOX_COLUMN
	
	lw $a0, BOX_ROW
	lw $a1, BOX_COLUMN
	li $a2, 0x0099ff33 
	jal draw_bitmap_box
	
	sb $zero, KEYBOARD_EVENT_PENDING
	beq $zero, $zero, check_for_event
	
	
d_pressed:
	lw $a0, BOX_ROW
	lw $a1, BOX_COLUMN
	li $a2, 0x00000000
	jal draw_bitmap_box
	
	lw $s2, BOX_COLUMN
	addi, $s2, $s2, 1	#d_pressed change column coordinate one right
	sw $s2, BOX_COLUMN
	
	lw $a0, BOX_ROW
	lw $a1, BOX_COLUMN
	li $a2, 0x0099ff33 
	jal draw_bitmap_box
	
	sb $zero, KEYBOARD_EVENT_PENDING
	beq $zero, $zero, check_for_event
	
	
w_pressed:
	lw $a0, BOX_ROW
	lw $a1, BOX_COLUMN
	li $a2, 0x00000000
	jal draw_bitmap_box
	
	lw $s2, BOX_ROW
	addi, $s2, $s2, -1 #w_pressed change row coordinate one up
	sw $s2, BOX_ROW
	
	lw $a0, BOX_ROW
	lw $a1, BOX_COLUMN
	li $a2, 0x0099ff33 
	jal draw_bitmap_box
	
	sb $zero, KEYBOARD_EVENT_PENDING
	beq $zero, $zero, check_for_event
	
	
x_pressed:
	lw $a0, BOX_ROW
	lw $a1, BOX_COLUMN
	li $a2, 0x00000000
	jal draw_bitmap_box
	
	lw $s2, BOX_ROW
	addi, $s2, $s2, 1	#w_pressed change row coordinate one down
	sw $s2, BOX_ROW
	
	lw $a0, BOX_ROW
	lw $a1, BOX_COLUMN
	li $a2, 0x0099ff33 
	jal draw_bitmap_box
	
	sb $zero, KEYBOARD_EVENT_PENDING
	beq $zero, $zero, check_for_event
	
	

.data
    .eqv BOX_COLOUR_BLACK 0x00000000
.text

	addi $v0, $zero, BOX_COLOUR_BLACK
	syscall



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
	
	
#-------------------------------------------------------------------


	.kdata
	
		# No data in the kernel-data section (at present)

	.ktext 0x80000180			# Required address in kernel space for exception dispatch
__kernel_entry:
	mfc0 $k0, $13			# $13 is the "cause" register in Coproc0
	andi $k1, $k0, 0x7c			# bits 2 to 6 are the ExcCode field (0 for interrupts)
	srl  $k1, $k1, 2			# shift ExcCode bits for easier comparison
	beq $zero, $k1, __is_interrupt
	
__is_exception:
					# Something of a placeholder...
					# ... just in case we can't escape the need for handling some exceptions.
	beq $zero, $zero, __exit_exception
	
__is_interrupt:
	andi $k1, $k0, 0x0100		# examine bit 8
	bne $k1, $zero, __is_keyboard_interrupt	# if bit 8 set, then we have a keyboard interrupt.
	
	beq $zero, $zero, __exit_exception	# otherwise, we return exit kernel
	
__is_keyboard_interrupt:

	lb $k0, 0xffff0004 			#data from keyboard
	sb $k0, KEYBOARD_EVENT
	
	li $k0, 1
	sb $k0, KEYBOARD_EVENT_PENDING
	# Note: We could also take the value obtained from the "lw:
	# and store it someplace in data memory. However, to keep
	# things simple, we're using $t7 immediately above.
	
	beq $zero, $zero, __exit_exception	# Kept here in case we add more handlers.
	
	
__exit_exception:
	eret
	

.data

# Any additional .text area "variables" that you need can
# be added in this spot. The assembler will ensure that whatever
# directives appear here will be placed in memory following the
# data items at the top of this file.

	
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE


.eqv BOX_COLOUR_WHITE 0x00FFFFFF
	
