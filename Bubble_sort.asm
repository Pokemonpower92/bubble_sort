# Right now the array is global
# ToDo - Add functionality for user-generated array
.data
	list: .word 7, 9, 4, 1, 10, 2, 7, 4
	size: .word 8
	newLine: .asciiz "\n"
.text
	j main

	# Sort an array. Return number of swaps to $v0
	sort:

		# Move array pointer to element 2
		addi $a0, $a0, 4
		
		# Move the original pointer to the stack
		addi $sp, $sp, -8
		sw $a0, 0($sp)
		
		# num_swaps = $v0, swapped = $t1
		# $t2 holds the true check for the 
		# do-while loop
		addi $v0, $zero, 0
		addi $t1, $zero, 0
		addi $t2, $zero, 1

		# Do-while logic
		do:
			# Swapped is false
			move $t1, $zero
			# Reset the array pointer
			lw $a0, 0($sp)
			# i for for loop
			addi $t3, $zero, 1
			# For loop logic
			while:
				# $t3 = i, $a1 = size
				bge $t3, $a1, after
				# $t4 = a[i-1]. $t5 = a[i]
				lw $t4, -4($a0)
				lw $t5, 0($a0)
				
				ble $t4, $t5, else
					addi $t1, $zero, 1
					addi $v0, $v0, 1
					# Swap the values
					sw $t5, -4($a0)
					sw $t4, 0($a0)
				else:
				# Incrementation
				addi $t3, $t3, 1
				addi $a0, $a0, 4
				j while
				after:
		beq $t1, $t2, do
	
		# Deallocate Stack
		addi $sp, $sp, 8
	
		jr $ra
			
	main:
		# Load the arguments.
		la $a0, list
		lw $a1, size
		jal sort

			
	
