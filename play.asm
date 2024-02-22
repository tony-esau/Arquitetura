.include "macros.asm"

.globl play

play: 
	save_context
	#int play(int board[][SIZE] ($s0), int row ($s1), int column ($s2)) 
	move $s0, $a0 #inicio da matriz
	move $s1, $a1 #índice da linha do elemento
	move $s2, $a2 #índice da coluna do elemento
	
	# Tomando valor de board[row}[column] 
	sll $t0, $s1, 5 #percorre linhas
	sll $t1, $s2, 2 #percorre colunas
	add $t2, $t0, $t1 #endereço parcial de board[row}[column]
	add $s4, $t2, $s0 #adiciona o endereço inicial da matriz
	
	lw $s3,0($s4) #carregando valor de board[row}[column] para $s3
		
	li $t3, -1 #-1 para comparação
	
	#if (board[row][column] == -1) 
	beq $s3, $t3, acertou_bomba
	
	li $t3, -2 #-2 para comparação
	#if (board[row][column] == -2)
	j jogo_continua
	
	acertou_bomba:
		li $v0, 0
		restore_context
		jr $ra #return 0; Acertou uma bomba.
		
	jogo_continua:
		jal countAdjacentBombs #countAdjacentBombs(board, row, column)
		sw $v0, 0($s4) #board[row][column] = x
		beq $v0, $zero, revelar_celulas #(!x), revelar células
		
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
