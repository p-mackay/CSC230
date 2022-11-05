# UVic CSC 230, Fall 2020
# Assignment #1, part A

# Student name: Paul MacKay
# Student number: V00967869


# Compute odd parity of word that must be in register $8
# Value of odd parity (0 or 1) must be in register $15


.text

start:
	lw $8, testcase1  # STUDENTS MAY MODIFY THE TESTCASE GIVEN IN THIS LINE
	#lw $8, testcase2
	#lw $8, testcase3
# STUDENTS MAY MODIFY CODE BELOW
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	addiu $15, $0, 0	#to hold PARITY
	li $5, 0 	#counter used in loop
	li $6, 0 	#register to hold the right most bit of the word(testcase)
	li $9, 1	#mask to test the least significant bit(LSB) of the testcase
	li $10, 0 	#counter for number of 1's in the testcase
	li $11, 0 	#stores the result of bitwise ANDING $10 and $9 to get parity (if the result is a one then there is an odd amount of one's
			# in the word, if its a zero then there are an even amount of ones).

loop:			#***the purpose of this block is to count the number of one's***
	beq $5, 32, end 	#while($5 != 32){
	and $6, $8, $9 		#use bitwise AND on the testcase and $9 to calculate the value of the LSB in $8
	bne $6, 1, zero 	#if(LSB == 1){
	addi $10, $10, 1 	#that means the LSB is a one therefor counter of 1's++
	srl $8, $8, 1 		#shift the testcase word one bit to the right
	
	addi $5, $5, 1 		#increment loop counter
	j loop			#jump to the beginning of the loop
zero:	
	srl $8, $8, 1		#else{ that means the LSB of the testcase was a zero. Now shift the testcase right one bit
	addi $5, $5, 1		#while loop increment 
	j loop			#jump to the beginning of the loop


end: 

if:			#***the purpose of this block is to see if there are a even or odd amount of 1's***
			#Now that we have calculated the number of one's its time to calculate if that number is even or odd
			#This can be done by calculating the value of the LSB. To calculate odd perity 
			#if the value is even then add a one, if its odd than add a zero
	and $11, $10, $9	#calculate the LSB using the 0001 mask 
	bne $11, 1, even	#if the LSB is zero that means its odd
	addi $15, $15, 0	#therefore add a zero 
	j end_if		#we are done... end the program
even:	
	addi $15, $15, 1	#if the LSB is a 1 that means its even, therefore add one to it
	j end_if		#we are done... end the program
end_if: 
	nop


# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
# STUDENTS MAY MODIFY CODE ABOVE


exit:
	add $2, $0, 10
	syscall
		

.data

testcase1:
	.word	0x00200020    # odd parity is 1

testcase2:
	.word 	0x00300020    # odd parity is 0
	
testcase3:
	.word  0x1234fedc     # odd parity is 0

