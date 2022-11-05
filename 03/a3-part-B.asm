	.data
KEYBOARD_EVENT_PENDING:	#boolean either 1 or 0
	.word	0x0
KEYBOARD_EVENT:		#keyboard data
	.word   0x0
KEYBOARD_COUNTS:
	.space  128
NEWLINE:
	.asciiz "\n"
SPACE:
	.asciiz " "
	
	
	.eqv 	LETTER_a 97
	.eqv	LETTER_b 98
	.eqv	LETTER_c 99
	.eqv 	LETTER_D 100
	.eqv 	LETTER_space 32
	
	
	.text  
main:
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	la $s0, 0xffff0000	# control register for MMIO Simulator "Receiver"
	lb $s1, 0($s0)
	ori $s1, $s1, 0x02	# Set bit 1 to enable "Receiver" interrupts (i.e., keyboard)
	sb $s1, 0($s0)
	
	li $s0, 0
	sb $s0, KEYBOARD_EVENT_PENDING
	
check_for_event:
	
	lbu $s0, KEYBOARD_EVENT_PENDING
	beq $s0, $zero, check_for_event
	
	# check for the space key - if so, we'll quit
	lbu $s1, KEYBOARD_EVENT
	beq $s1, ' ', display_and_quit
	
	#otherwise, check to see if a, b, c, or d
	bgt $s1, 'd', finished_processing_character
	blt $s1, 'a', finished_processing_character
	lw $s2, KEYBOARD_COUNTS
	addi, $s2, $s2, 1
	sw $s2, KEYBOARD_COUNTS
	b finished_processing_character
	
finished_processing_character:
	sb $zero, KEYBOARD_EVENT_PENDING
	beq $zero, $zero, check_for_event
	
display_and_quit:

	lw $a0, KEYBOARD_COUNTS		
	addi $v0, $zero, 1
	syscall
	
	
	addi $v0, $zero, 10
	syscall

	.kdata
	
	# No data in the kernel-data section (at present)

	.ktext 0x80000180	# Required address in kernel space for exception dispatch
__kernel_entry:
	mfc0 $k0, $13		# $13 is the "cause" register in Coproc0
	andi $k1, $k0, 0x7c	# bits 2 to 6 are the ExcCode field (0 for interrupts)
	srl  $k1, $k1, 2	# shift ExcCode bits for easier comparison
	beq $zero, $k1, __is_interrupt
	
__is_exception:
	# Something of a placeholder...
	# ... just in case we can't escape the need for handling some exceptions.
	beq $zero, $zero, __exit_exception
	
__is_interrupt:
	andi $k1, $k0, 0x0100	# examine bit 8
	bne $k1, $zero, __is_keyboard_interrupt	 # if bit 8 set, then we have a keyboard interrupt.
	
	beq $zero, $zero, __exit_exception	# otherwise, we return exit kernel
	
__is_keyboard_interrupt:

	lb $k0, 0xffff0004 #data from keyboard
	sb $k0, KEYBOARD_EVENT
	
	li $k0, 1
	sb $k0, KEYBOARD_EVENT_PENDING
	# Note: We could also take the value obtained from the "lw:
	# and store it someplace in data memory. However, to keep
	# things simple, we're using $t7 immediately above.
	
	beq $zero, $zero, __exit_exception	# Kept here in case we add more handlers.
	
	
__exit_exception:
	eret
	
	
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE

	
