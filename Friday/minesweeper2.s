.text
hasBomb:
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)

	#5x9
	#Get the Max Column
	la $s0, gameCols	#Max Col (addr)
	lw $s1, 0($s0)		#Max Col(9) (value)

	#Get the row/col values
	move $s0, $a0 		#Row byte(3)
							#(Because Gameboard is Stored as byte array)
	
	move $s2, $a1			#column byte position(4)

	#Getting the position of the tile
	mult $s0, $s1		#row*columnSize(3*9)
	mflo $s0
	add $s0, $s0, $s2	#row*columnSize + col (3*9+4)

	la $s1, gameBoard 	#Get the address of the board
	
	add $s1, $s1, $s0	#Tile position in the board
	
	####### Check if Bomb ###########
	#check if it is a Bomb
	andi $s3, $s1, 0x01		#getting the first bit
	beq $s3, 0x01, isBomb	
	li $v0, 0

	j endHasBomb

	isBomb:
		li $v0, 1
	
		j endHasBomb

	endHasBomb:	
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		addi $sp, $sp, 20

		jr $ra


.text
setBomb:
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)

	#sets the tile to be a bomb
	#5x9
	#Get the Max Column
	la $s0, gameCols	#Max Col (addr)
	lw $s1, 0($s0)		#Max Col(9) (value)

	#Get the row/col values
	move $s0, $a0 		#Row byte(3)
							#(Because Gameboard is Stored as byte array)
	
	move $s2, $a1			#column byte position(4)

	#Getting the position of the tile
	mult $s0, $s1		#row*columnSize(3*9)
	mflo $s0
	add $s0, $s0, $s2	#row*columnSize + col (3*9+4)

	la $s1, gameBoard 	#Get the address of the board
	
	add $s1, $s1, $s0	#Tile position in the board

	#######Setting Up Bombs ###########

	#setting it to a bomb (unrevealed ?)
	li $s3, 0x01 		#loading byte to s3
	sb $s3, 0($s1)		#putting the byte 1 at the position

	lw $ra, 0($sp)
	lw $s0, 4($sp)
	lw $s1, 8($sp)
	lw $s2, 12($sp)
	lw $s3, 16($sp)
	addi $sp, $sp, 20

	jr $ra


.text
prepareBoard:
	addi $sp, $sp, -36
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)
	sw $s5, 24($sp)
	sw $s6, 28($sp)
	sw $s7, 32($sp)


	la $s0, gameRows	#Total number of Rows(4)
	lw $s1, 0($s0)

	la $s2, gameCols 	#Total number of Columns(4)
	lw $s3, 0($s2)

	mult $s3, $s1		#Column*Row (4*4)
	mflo $s2

	la $s0, gameBoard 	#getting the first position

	add $s2, $s0, $s2

	loop:
		beq $s0, $s2, endPrepareBoard
		# lb $s4, 0($s0)	#getting the word at the address of gameboard
		# li $s7, 0
		# bne $s4, 0x01, checkBomb
		# j ContinueLoop 

	ContinueLoop:
	
		addi $s0, $s0, 1
		j loop

	######Checking If Bomb around the number#######
	checkBomb:

	# 	beq $s7, 0, goBackRow
	# 	beq $s7, 1, goFrontRow
	# 	beq $s7, 2, goOriginalPos
	# 	beq $s7, 3, endCheckBomb

	# goBackRow:
	# 	addi $s7, $s7, 1
	# 	sub $s0, $s0, $s1
	# 	j continue

	# goFrontRow:
	# 	addi $s7, $s7, 1
	# 	add $s0, $s0, $s1
	# 	add $s0, $s0, $s1
	# 	j continue

	# goOriginalPos:
	# 	addi $s7, $s7, 1
	# 	sub $s0, $s0, $s1
	# 	j continue


	# continue:

	# 	lb $s5, 0($s0)
	# 	bne $s5, 0x01, continue1

	# 	sra $s0, $s0, 4
	# 	addi $s0, $s0, 1
	# 	sll $s0, $s0, 4

	# continue1:

	# 	beq $s0, 0, continue2

	# 	addi $s0, $s0, -1
	# 	lb $s5, 0($s0)
	#  	bne $s5, 0x01, continue2

	# 	sra $s0, $s0, 4
	# 	addi $s0, $s0, 0x01
	# 	sll $s0, $s0, 4

	# continue2:

	#  	addi $s0, $s0, 1
	 	
	#  	beq $s0, $s3, continue3

	#  	addi $s0, $s0, 1

	#  	lb $s5, 0($s0)
	#  	bne $s5, 0x01, continue3

	#  	sra $s0, $s0, 4
	#  	addi $s0, $s0, 1
	#  	sll $s0, $s0, 4

	#  continue3:
		
	#  	addi $s0, $s0, 1

	#  	j checkBomb


	endCheckBomb:
	  	j ContinueLoop

	endPrepareBoard:
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		lw $s4, 20($sp)
		lw $s5, 24($sp)
		lw $s6, 28($sp)
		lw $s7, 32($sp)
		addi $sp, $sp, 36

		jr $ra



.text
printTile:
	addi $sp, $sp, -24
	sw $ra, 0($sp)
	sw $s0, 4($sp)
	sw $s1, 8($sp)
	sw $s2, 12($sp)
	sw $s3, 16($sp)
	sw $s4, 20($sp)


	#5x9
	#Get the Max Column
	la $s0, gameCols	#Max Col (addr)
	lw $s1, 0($s0)		#Max Col(9) (value)

	#Get the row/col values
	move $s0, $a0		#Row byte(3)
						#(Because Gameboard is Stored as byte array)
	
	move $s2, $a1		#column byte position(4)

	#Getting the position of the tile
	mult $s0, $s1		#row*columnSize(3*9)
	mflo $s0
	add $s0, $s0, $s2	#row*columnSize + col (3*9+4)

	la $s1, gameBoard 	#Get the address of the board
	
	add $s1, $s1, $s0	#Tile position in the board

	#####Printing the bombs########
	lb $s4, 0($s1)
	beq $s4, 0x01, printBomb
	
	sra $s1, $s1, 4
	move $s4, $s1

	beq $s4, 0, print0
	beq $s4, 1, print1
	# beq $s4, 2, print2
	# beq $s4, 3, print3
	# beq $s4, 4, print4
	# beq $s4, 5, print5
	# beq $s4, 6, print6
	# beq $s4, 7, print7
	# beq $s4, 8, print8
	sll $s1, $s1, 4

	la $s3, tile
	move $a2, $a1
	move $a1, $a0
	move $a0, $s3
	
	jal printString
	
	j endPrintTile

	printBomb:
		la $s3, bomb
		move $a2, $a1
		move $a1, $a0
		move $a0, $s3
	
		jal printString

		j endPrintTile

	print0:
		sll $s1, $s1, 4
		la $s3, has0
		move $a2, $a1
		move $a1, $a0
		move $a0, $s3
	
		jal printString

		j endPrintTile

	print1:
		sll $s1, $s1, 4
		la $s3, has1
		move $a2, $a1
		move $a1, $a0
		move $a0, $s3
	
		jal printString

		j endPrintTile

	endPrintTile:
		lw $ra, 0($sp)
		lw $s0, 4($sp)
		lw $s1, 8($sp)
		lw $s2, 12($sp)
		lw $s3, 16($sp)
		lw $s4, 20($sp)
		addi $sp, $sp, 24
	
		jr $ra

