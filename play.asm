.include "macros.asm"

.globl play

play: 
	save_context
	#int play(int board[][SIZE] ($s0), int row ($s1), int column ($s2)) 
	move $s0, $a0 #inicio da matriz
	move $s1, $a1 #�ndice da linha do elemento
	move $s2, $a2 #�ndice da coluna do elemento
	
	# Tomando valor de board[row}[column] 
	sll $t0, $s1, 5 #percorre linhas
	sll $t1, $s2, 2 #percorre colunas
	add $t2, $t0, $t1 #endere�o parcial de board[row}[column]
	add $t2, $t2, $s0 #adiciona o endere�o inicial da matriz
	
	lw $s3,0($t2) #carregando valor de board[row}[column] para $s3
		
	li $t3, -1 #-1 para compara��o
	
	#if (board[row][column] == -1) 
	beq $s3, $t3, acertou_bomba
	
	li $t3, -2 #-2 para compara��o
	#if (board[row][column] == -2)
	beq $s3, $t3, jogo_continua
	
	acertou_bomba:
		li $v0, 0
		restore_context
		jr $ra #return 0; Acertou uma bomba.
		
	jogo_continua:
		jal countAdjacentBombs #countAdjacentBombs(board, row, column)
		sw $v0, 0($t1) #board[row][column] = x
		beq $v0, $zero, revelar_celulas #(!x), revelar c�lulas
		
		li $v0, 1
		restore_context
		jr $ra #return 1
		
		revelar_celulas:
		jal revealNeighboringCells #revealAdjacentCells(board, row, column); 
		li $v0, 1 
		restore_context
		jr $ra #return 1

	
		

 #int play(int board[][SIZE], int row, int column) {
   #// Performs the move
   #if (board[row][column] == -1) {
     #return 0; // Player hit a bomb, game over
   #}
   #if (board[row][column] == -2) {
     #int x = countAdjacentBombs(board, row, column); // Marks as revealed
     #board[row][column] = x;
   #if (!x)
     #revealAdjacentCells(board, row, column); // Reveals adjacent cells
   #}
     #return 1; // Game continues
   #}
