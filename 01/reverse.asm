# UVic CSC 230, Fall 2020
# Assignment #1, part B

# Student name: Paul MacKay
# Student number: V00967869


# Compute the reverse of the input bit sequence that must be stored
# in register $8, and the reverse must be in register $15.


.text
start:
	#lw $8, testcase1 
	lw $8, testcase2 
	#lw $8, testcase3   #WORD STUDENTS MAY MODIFY THE TESTCASE GIVEN IN THIS LINE
	
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	li $5, 0 	#counter
	li $6, 1 	#register containing 1
	li $7, 0 	#register to hold the result of bitwise AND of ...0001 and the testcase
	li $15, 0 	#RESULT
	
loop: 
	beq $5, 32, end 	#while ($5 != 32) 
	sll $15, $15, 1 	#shift the reversed word to the left by 1
	
	and $7, $8, $6 		#perform bitwise AND between testcase and ...0001 temporaraly 
	bne $7, 1, else		#if(($7 & 1) == 1){
	addiu  $15, $15, 1 	#add 1 to the least significant bit
	srl $8, $8, 1 		#shift word to the right
	
	addiu $5, $5, 1		#counter++} 
	j loop			#return to loop
else: 
 	addiu $5, $5, 1		#in this case the LSB in testcase word was 0
 	srl $8, $8, 1		#so we shift the testcase right
 	j loop 			#jump back to the top of the loop
 	

end:
	nop
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE

exit:
	add $2, $0, 10
	syscall
	
	

.data

testcase1:
	.word	0x00200020    # reverse is 0x04000400

testcase2:
	.word 	0x00300020    # reverse is 0x04000c00
	
testcase3:
	.word	0x1234fedc     # reverse is 0x3b7f2c48
