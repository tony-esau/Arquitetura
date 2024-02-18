.include "macros.asm"

.globl revealNeighboringCells

revealNeighboringCells:
	save_context
	move $s0, $a0 #inicio da matriz
	move $s1, $a1 #índice da linha do elemento
	move $s2, $a2 #índice da coluna do elemento
	
	#Inicio e limite do laço i
	subi $s3, $s1, 1 #i = row - 1
	addi $s4, $s1, 1 #row + 1
	
	begin_for_i_it:
	      bgt $s3, $s4, end_for_i_it #i > row + 1
	      
	      #Inicio e limite do laço j
	      subi $s5, $s2, 1 #j = column - 1
	      addi $s6, $s2, 1 #column + 1
	      
	      begin_for_j_it:
	            bgt $s5, $6, end_for_j_it #j > column + 1
	            
	            li $t0, SIZE #SIZE = 8
	            
	            blt $s3, $zero, increment_j_and_jump #i < 0
	            bge $s3, $t0, increment_j_and_jump #i >= SIZE
	            blt $s5, $zero, increment_j_and_jump #j<0
	            bge $s5, $t0, increment_j_and_jump #j>=SIZE
	            
	            #para verificar se board[i][j] == -2
	            sll $t1, $s3, 5 #percorre linhas
	            sll $t2, $s5, 2 #percorre colunas
	            add $t1, $t1, $t2 #calculo do endereço
	            add $t1, $t1, $s0 #calculo do endereço em relação ao inicio da matriz
	            lw $t2, 0($t1)# board[i][j] = $t2
	            
	            li $t3, -2 #-2 para comparação
	            
	            bne $t2, $t3, increment_j_and_jump #board[i][j] != -2)
	            
	            move $a1, $s3 #i é agora o parâmetro 2
	            move $a2, $s5 #j é agora o parâmetro 3
	            jal countAdjacentBombs #chama a função de contar ao redor
	            sw $v0, 0($t1) #board[i][j] = x;
	            
	            bne $v0, $zero, increment_j_and_jump #x != 0
	            
	            jal revealNeighboringCells #chamada recursiva
	                              
	            increment_j_and_jump:
	                      addi $s5, $s5, 1
	                      j begin_for_j_it
	            	 
	            
	            end_for_j_it:
	            	addi $s3, $s3, 1 #i++
	            	j begin_for_i_it
	      
	end_for_i_it:
		restore_context
		jr $ra
	
    #void revealAdjacentCells(int board[][SIZE], int row, int column) {
        #// Reveals the adjacent cells of an empty cell
        #for (int i = row - 1; i <= row + 1; ++i) {
            #for (int j = column - 1; j <= column + 1; ++j) {
                #if (i >= 0 && i < SIZE && j >= 0 && j < SIZE && board[i][j] == -2) {
                    #int x = countAdjacentBombs(board, i, j); // Marks as revealed
                    #board[i][j] = x;
                    #if (!x)
                        #revealAdjacentCells(board, i, j); // Continues the revelation recursively
                #}
            #}
        #}
    #}
	
	
	
