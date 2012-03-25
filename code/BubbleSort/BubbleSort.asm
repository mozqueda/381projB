
	.data
arr:  	.word 1, 4, 3, 1 
	.text
	.globl main
main:
	addiu $t0, $zero, 4  #load size of n (this is the size of the array. The only value that we can change)
	addiu $t1, $zero, 1  #load flag. '1' means swapped
	addiu $t3, $zero, 0  #load base address of array(our processor doesnt support this instruction)
			     #Instead we can just load a 0 by doing an addiu instruction
			     #The the array will have a starting address of 0. 
while:  beq $t1, $zero, endWhile
	addiu $t1, $zero, 0  #not swapped
	sub $t0, $t0 , 1     #n = n - 1
	addiu $t2, $zero, 0  #load i = 0
loop:   beq $t2, $t0 while   #branch if i == n	
 	sll $t4, $t2, 2	     # i * 4
 	add $t4, $t4, $t3    # address of arr[i]
 	lw $s0, ($t4)	     #store arr[i]
 	lw $s1, 4($t4)	     #store arr[i + 1]      	     
 	
 	sub $t5, $s1, $s0    #if s1 - s0 > 0, then the two are in the correct order
 	bgtz $t5, inc	     #if s1 is bigger, then jump to the increment part
 	sw $s1, ($t4)        #the following two lines swap the two elements. No need for a temp register
 	sw $s0, 4($t4)	 
 	addiu $t1, $zero, 1  #swapped
 inc:	add $t2, $t2, 1      #i = i + 1
 	j loop 	 	
 	 	 	
endWhile:

