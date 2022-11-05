.text


main:	



# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

	## Test code that calls procedure for part A
	#jal save_our_souls

	#morse_flash test for part B
	
	#addi $a0, $zero, 0x42   # dot dot dash dot
	#jal morse_flash
	
	##morse_flash test for part B
	# addi $a0, $zero, 0x37   # dash dash dash
	# jal morse_flash
		
	## morse_flash test for part B
	#addi $a0, $zero, 0x32  	# dot dash dot
	#jal morse_flash
			
	## morse_flash test for part B
	#addi $a0, $zero, 0x11   # dash
	#jal morse_flash	
	
	# flash_message test for part C
	#la $a0, test_buffer
	#jal flash_message
	
	# letter_to_code test for part D
	# the letter 'P' is properly encoded as 0x46.
	 #addi $a0, $zero, 'P'
	 #jal letter_to_code
	
	# letter_to_code test for part D
	# the letter 'A' is properly encoded as 0x21
	# addi $a0, $zero, 'A'
	# jal letter_to_code
	
	# letter_to_code test for part D
	# the space' is properly encoded as 0xff
	# addi $a0, $zero, ' '
	# jal letter_to_code
	
	# encode_message test for part E
	# The outcome of the procedure is here
	# immediately used by flash_message
	# la $a0, message01
	# la $a1, buffer01
	# jal encode_message
	# la $a0, buffer01
	# jal flash_message
	
	
	# Proper exit from the program.
	addi $v0, $zero, 10
	syscall

	
	
###########
# PROCEDURE
save_our_souls:

	jal seven_segment_on #dot
	jal delay_short
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on #dot
	jal delay_short
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on #dot
	jal delay_short
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on #dash
	jal delay_long
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on #dash
	jal delay_long
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on #dash
	jal delay_long
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on #dot
	jal delay_short
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on #dot
	jal delay_short
	jal seven_segment_off
	jal delay_long
	
	jal seven_segment_on #dot
	jal delay_short
	jal seven_segment_off
	jal delay_long



	jr $ra


# PROCEDURE addi $a0, $zero, 0x42   # dot dot dash dot
morse_flash:

	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s0, 16($sp)
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	beq $a0, 0xff, morse_space

	add $s2, $s2, $0		#counter
	add $s3, $s3, $0		#buffer
	add $s0, $s0, $a0		#copy original byte into $s0 high nybble --> size
	add $s1, $s1, $a0		#copy original byto into $s1 low nybble  --> sequence
	addi $t7, $t7, 4		#temp1 = 4
	add $t6, $t6, 0			#result = 0
	
	
	srl $s0, $s0, 4			#high nybble --> size
	andi $s1, $s1, 0x0000000f	#low nybble  --> sequence
	
	ror $s1, $s1, 4
	sub $t6, $t7, $s0
	sllv $s1, $s1, $t6		#shift 4 - size to the left

	
	
	
loop:	
	
	
	andi $s3, $s1, 0x80000000	#mask 1000...
		
	beq $s3, 0x00000000, dot
	beq $s3, 0x80000000, dash
	
	
	beq $s0, 0, end
	
	
dash:	
	
	
	jal seven_segment_on #dash
	jal delay_long
	jal seven_segment_off
	jal delay_long
		
	addi $s0, $s0, -1
	sll $s1, $s1, 1
	beq $s0, 0, end
	
	j loop

dot:
	
	jal seven_segment_on #dot
	jal delay_short
	jal seven_segment_off
	jal delay_long
	
	addi $s0, $s0, -1
	sll $s1, $s1, 1
	beq $s0, 0, end
	j loop
	

	
morse_space:
	
	jal seven_segment_off
	jal delay_long
	jal delay_long
	jal delay_long
	
	j loop
###########
# PROCEDURE la $a0, test_buffer -> S0S	
flash_message:
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $ra, 16($sp)
	
	add $s0, $s0, $a0	#copy string
	
flash_loop:
	beq $a0, 0, end		#while current != 0 

	lb $a0, 0($s0)		#load the current byte into $s1
	jal morse_flash		#go to function
	addi $s0, $s0, 1	#increment the address to get next byte
	
	
	j flash_loop
	
###########
# PROCEDURE		addi $a0, $zero, 'P'
letter_to_code:
	addi $sp, $sp, -20
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $ra, 16($sp)
	
	la $s0, codes
	
	addi $s1, $s1, 0		#register to store high nybble
	addi $s2, $s2, 0		#register to store low nybble
	addi $t5, $t5, 0		#byte pattern
	addi $t4, $t4, 0		#current
	addi $t3, $t3, 0		#counter	
	
	get_letter:
		lb $t4, 0($s0)		#load first byte form $s0 into $t4
		beq $a0, $t4, encode	#if we have a match then find out the code
		addi $s0, $s0, 8	#else add 8 to $s0, to get the next letter
		j get_letter
	encode:
		beq $t4, 0, end		#if current == 0 means its the end of the string
		addi $t3, $t3, 1	#else we have a character
		sll $t5, $t5, 1		#shift bit sequence one left
		subi $t8, $t4, 45	#check to see if current == dash or dot
		beq $t8, 1, go_to_dash	#if a 1 its a dash
		bne $t0, 0, go_to_dot	#if a 0 its a dot
		
	go_to_dash:
		addi $t5, $t5, 1	#add 1 to bit pattern 
		jal dash
	go_to_dot:
		jal dot			#shifting will create a 0 here
		
	


###########
# PROCEDURE
encode_message:
	jr $ra
	
end:
	addi $sp, $sp, -20
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	lw $s2, 8($sp)
	lw $s3, 12($sp)
	lw $s0, 16($sp)
	
	jr $ra
	

# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE

#############################################
# DO NOT MODIFY ANY OF THE CODE / LINES BELOW

###########
# PROCEDURE
seven_segment_on:
	la $t1, 0xffff0010     # location of bits for right digit
	addi $t2, $zero, 0xff  # All bits in byte are set, turning on all segments
	sb $t2, 0($t1)         # "Make it so!"
	jr $31


###########
# PROCEDURE
seven_segment_off:
	la $t1, 0xffff0010	# location of bits for right digit
	sb $zero, 0($t1)	# All bits in byte are unset, turning off all segments
	jr $31			# "Make it so!"
	

###########
# PROCEDURE
delay_long:
	add $sp, $sp, -4	# Reserve 
	sw $a0, 0($sp)
	addi $a0, $zero, 600
	addi $v0, $zero, 32
	syscall
	lw $a0, 0($sp)
	add $sp, $sp, 4
	jr $31

	
###########
# PROCEDURE			
delay_short:
	add $sp, $sp, -4
	sw $a0, 0($sp)
	addi $a0, $zero, 200
	addi $v0, $zero, 32
	syscall
	lw $a0, 0($sp)
	add $sp, $sp, 4
	jr $31




#############
# DATA MEMORY
.data
codes:
	.byte 'A', '.', '-', 0, 0, 0, 0, 0
	.byte 'B', '-', '.', '.', '.', 0, 0, 0
	.byte 'C', '-', '.', '-', '.', 0, 0, 0
	.byte 'D', '-', '.', '.', 0, 0, 0, 0
	.byte 'E', '.', 0, 0, 0, 0, 0, 0
	.byte 'F', '.', '.', '-', '.', 0, 0, 0
	.byte 'G', '-', '-', '.', 0, 0, 0, 0
	.byte 'H', '.', '.', '.', '.', 0, 0, 0
	.byte 'I', '.', '.', 0, 0, 0, 0, 0
	.byte 'J', '.', '-', '-', '-', 0, 0, 0
	.byte 'K', '-', '.', '-', 0, 0, 0, 0
	.byte 'L', '.', '-', '.', '.', 0, 0, 0
	.byte 'M', '-', '-', 0, 0, 0, 0, 0
	.byte 'N', '-', '.', 0, 0, 0, 0, 0
	.byte 'O', '-', '-', '-', 0, 0, 0, 0
	.byte 'P', '.', '-', '-', '.', 0, 0, 0
	.byte 'Q', '-', '-', '.', '-', 0, 0, 0
	.byte 'R', '.', '-', '.', 0, 0, 0, 0
	.byte 'S', '.', '.', '.', 0, 0, 0, 0
	.byte 'T', '-', 0, 0, 0, 0, 0, 0
	.byte 'U', '.', '.', '-', 0, 0, 0, 0
	.byte 'V', '.', '.', '.', '-', 0, 0, 0
	.byte 'W', '.', '-', '-', 0, 0, 0, 0
	.byte 'X', '-', '.', '.', '-', 0, 0, 0
	.byte 'Y', '-', '.', '-', '-', 0, 0, 0
	.byte 'Z', '-', '-', '.', '.', 0, 0, 0
	
message01:	.asciiz "A A A"
message02:	.asciiz "SOS"
message03:	.asciiz "WATERLOO"
message04:	.asciiz "DANCING QUEEN"
message05:	.asciiz "CHIQUITITA"
message06:	.asciiz "THE WINNER TAKES IT ALL"
message07:	.asciiz "MAMMA MIA"
message08:	.asciiz "TAKE A CHANCE ON ME"
message09:	.asciiz "KNOWING ME KNOWING YOU"
message10:	.asciiz "FERNANDO"

buffer01:	.space 128
buffer02:	.space 128
test_buffer:	.byte 0x30 0x37 0x30 0x00    # This is SOS
