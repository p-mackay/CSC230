
	.data
ARRAY_A:
	.word	21, 210, 49, 4
ARRAY_B:
	.word	21, -314159, 0x1000, 0x7fffffff, 3, 1, 4, 1, 5, 9, 2
ARRAY_Z:
	.space	28
NEWLINE:
	.asciiz "\n"
SPACE:
	.asciiz " "
		
	
	.text  
main:	
	la $a0, ARRAY_A
	addi $a1, $zero, 4
	jal dump_array
	
	la $a0, ARRAY_B
	addi $a1, $zero, 11
	jal dump_array
	
	la $a0, ARRAY_Z
	lw $t0, 0($a0)
	addi $t0, $t0, 1
	sw $t0, 0($a0)
	addi $a1, $zero, 9
	jal dump_array
		
	addi $v0, $zero, 10
	syscall

# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	
	
dump_array:
	li $a2, 0
	move $a3, $a0
loop:
	beq $a2, $a1, done
	lw $a0, 0($a3)
	addi $v0, $0, 1
	syscall
	addi $a3, $a3, 4
	addi $a2, $a2, 1
	addi $v0, $0, 4
	la $a0, SPACE
	syscall
	b loop
done:
	addi $v0, $0, 4
	la $a0, NEWLINE
	syscall 
	
	jr $ra
	
	
	
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE
