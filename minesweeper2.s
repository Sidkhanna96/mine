.data
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


#----------------------------------------------------------------------------#
.text
#first lets either print a tile or a bomb
printTile:


li $s7 1 #load value to be compared
li $s6 4 #elementSize
la $t0 tile
la $t1 bomb

move $s1 $a0 #rowIndex
move $s2 $a1 #columnIndex
sub $s2 $s2 $s7
la $s3 gameBoard #address of gameboard
la $s4 gameCols #number of columns

sub $s1 $s1 $s7 #rowi-1
mult $s1 $s4
mfhi $s5
add $s5 $s5 $s2
add $s5 $s5 $s3 #+base_addr

lb $s5 0($s5) #get value at address
beq $s5 $s7 printBomb #if equal to 1 go to bomb
move $a2 $a1
move $a1 $a0
move $a0 $t0
jal printString

jr $ra

printBomb:
move $a2 $a1
move $a1 $a0
move $a0 $t1

jal printString
jr $ra

#----------------------------------------------------------------------------#
.text
prepareBoard:
jr $ra

