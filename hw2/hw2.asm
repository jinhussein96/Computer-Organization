	.data
str:
	.asciiz  "POSSIBLE "
	
str2  :
	.asciiz "NOT POSSIBLE "
arr:    .space 400
arraysize: .word 0
num:  .word 0

	.text
	.globl main
main:
 	
 	li $v0 , 5   #readinG ARRAy size from user
 	syscall 
 	sw $v0 , arraysize
 	
 	
 	li $v0 , 5 #reading num from user 
 	syscall 
 	sw $v0 , num
 	
 	jal read_array
 	#jal print_array
 	####### prepareing the parameters ########
 	la $a0 , arr      #a0 = arr 
 	lw $a1 , num        #a1 = num
 	lw $a2 , arraysize  # a2 = arraysize
 	li $t1 , 4          #t1= 4 
	mult $a2 , $t1      #arraysize * 4
	mflo $t1             #t1 = the product of arraysize * 4
	add $a0 , $a0 , $t1    #move the array pointer to point at the last element in the aray
 	jal CheckSumPossibility  # call function 
 	li $v0 , 4 
 	la $a0 , str2
 	syscall 		
 	j exit
 
 read_array:    #reading the array from the user
 	lw $t0 , arraysize
 	li $t1 , 0
 	la $a0 , arr
 	loop:
 		beq $t0 , $t1 , endloop
 		li $v0 , 5
 		syscall
 		sw $v0 , 0($a0)
 		addi $a0 , $a0 , 4   
 		addi $t1 , $t1 , 1
 		j loop
 	endloop:
 		jr $ra
 
 exit:
    	li  $v0, 10              # terminate 
    	syscall         	
print_array:
	lw $t0 , arraysize
 	li $t1 , 0
 	la $a1 , arr
 	loop1:
 		beq $t0 , $t1 , endloop1
 		lw $a0 , 0($a1)
 		addi $a1 ,$a1,4
 		li $v0 , 1
 		syscall
 		 
 		addi $t1 , $t1 , 1
 		j loop1
 	endloop1:
 		jr $ra	
CheckSumPossibility:
	beq $a1 , $zero , RETURN_1 #  if (num == 0 ) return 1;
	bnez $a1 , AND        #  else if (size == 0 && num != 0) return 0; 
	back:

		lw $t1 , 0($a0)		
		blt $a1 , $t1 , condition_1  #if(arr[size-1] > num)
		j condition_2      #else 
	jr $ra
	 	
AND:
	beq $a2 , $zero , RETURN_0 # retuen 0 
	j back
		 	
RETURN_1 :
	li $v0 , 4  #print string and exit
 	la $a0 , str
 	syscall 		
 	j exit
RETURN_0:
	li $v0 , 4    #print string and exit
 	la $a0 , str2
 	syscall 		
 	j exit


condition_1:
	addi $a0 , $a0 , -4
	addi $a2 ,$a2 ,-1 
	j CheckSumPossibility
	
condition_2:
	sub  $a1 , $a1 , $t1
	addi $a0 , $a0 , -4 
	addi $a2 ,$a2 ,-1 
	j CheckSumPossibility
