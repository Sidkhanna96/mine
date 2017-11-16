.text
getTile:
	#5x9
	#Get the Max Column
	la $s0, gameCols	#Max Col (addr)
	lw $s1, 0($s0)		#Max Col(9) (value)

	#Get the row/col values
	lbu $s0, 0($a0) 		#Row byte(3)
						#(Because Gameboard is Stored as byte array)
	
	lbu $s2, 0($a1)			#column byte position(4)

	#Getting the position of the tile
	mult $s0, $s1		#row*columnSize(3*9)
	mflo $s0
	add $s0, $s0, $s2	#row*columnSize + col (3*9+4)

	la $s1, gameBoard 	#Get the address of the board
	
	add $s1, $s1, $s0	#Tile position

	la $s3, tile

	lw $v0, 0($s3)

.text
hasBomb:
	#5x9
	#Get the Max Column
	la $s0, gameCols	#Max Col (addr)
	lw $s1, 0($s0)		#Max Col(9) (value)

	#Get the row/col values
	lbu $s0, 0($a0) 		#Row byte(3)
						#(Because Gameboard is Stored as byte array)
	
	lbu $s2, 0($a1)			#column byte position(4)

	#Getting the position of the tile
	mult $s0, $s1		#row*columnSize(3*9)
	mflo $s0
	add $s0, $s0, $s2	#row*columnSize + col (3*9+4)

	la $s1, gameBoard 	#Get the address of the board
	
	add $s1, $s1, $s0	#Tile position
	
	#check if it is a Bomb
	andi $s1, $s1, 0x01		#getting the first bit
	beq $s1, 0x01, isBomb	
	li $v0, 0
	jr $ra

	isBomb:
		li $v0, 1
		jr $ra

.text
setBomb:
	#sets the tile to be a bomb
	#5x9
	#Get the Max Column
	la $s0, gameCols	#Max Col (addr)
	lw $s1, 0($s0)		#Max Col(9) (value)

	#Get the row/col values
	lbu $s0, 0($a0) 		#Row byte(3)
						#(Because Gameboard is Stored as byte array)
	
	lbu $s2, 0($a1)			#column byte position(4)

	#Getting the position of the tile
	mult $s0, $s1		#row*columnSize(3*9)
	mflo $s0
	add $s0, $s0, $s2	#row*columnSize + col (3*9+4)

	la $s1, gameBoard 	#Get the address of the board
	
	add $s1, $s1, $s0	#Tile position

	#setting it to a bomb (unrevealed ?)
	lbu $s3, 0x01 		#loading byte to s3
	sb $s1, 0($s3)		#putting the byte 1 at the position

	jr $ra

prepareBoard:
	jr $ra

printTile:
	#5x9
	#Get the Max Column
	la $s0, gameCols	#Max Col (addr)
	lw $s1, 0($s0)		#Max Col(9) (value)

	#Get the row/col values
	lbu $s0, 0($a0) 		#Row byte(3)
						#(Because Gameboard is Stored as byte array)
	
	lbu $s2, 0($a1)			#column byte position(4)

	#Getting the position of the tile
	mult $s0, $s1		#row*columnSize(3*9)
	mflo $s0
	add $s0, $s0, $s2	#row*columnSize + col (3*9+4)

	la $s1, gameBoard 	#Get the address of the board

	#Printing Tile
	
	la $s3, tile

	lw $a0, 0($s3)
	move $a2, $a1
	move $a1, $a0
	
