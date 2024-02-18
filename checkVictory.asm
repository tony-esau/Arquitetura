.include "macros.asm"

.globl checkVictory

checkVictory:
	save_context
	move $s0, $a0 #inicio da matriz
	
	li $s1, 0 #contador
	
	li $s2, 0 #i = 0
	begin_for_i_it:
	      li $t0, SIZE #tamanho da matriz
	      bge $s2, $t0, end_for_i_it #i>=SIZE
	      
	      li $s3, 0 #j = 0 
	      begin_for_j_it:
	            bge $s3, $t0, end_for_j_it #j>=SIZE
	      	    
	      	    #Obtendo valor de board[i][j]
	      	    sll $t1, $s2, 5 #percorre linhas
	      	    sll $t2, $s3, 2 #percorre colunas
	      	    add $t1, $t1, $t2 
	      	    add $t1, $t1, $s0 #$t1 é o endereço de board[i][j]
	      	    
	      	    lw $s4, 0($t1)#$s4 = board[i][j]
	      	    
	      	    #if (board[i][j] < 0)
	      	    blt $s4, $zero, increment_j_and_jump
	      	    
	      	    addi $s1, $s1, 1 #contador++
	      	    increment_j_and_jump:
	      	    	addi $s3, $s3, 1 #j++
	      	    	j begin_for_j_it
	      	    
	      end_for_j_it:
	          addi $s2, $s2, 1 #i++
	          j begin_for_i_it
	end_for_i_it:
		li $t3, BOMB_COUNT #$t3 = BOMB_COUNT = 10
		mul $t0, $t0, $t0 #$t0 = SIZE * SIZE
		sub $t0, $t0, $t3 #SIZE * SIZE - BOMB_COUNT
		
		blt $s1, $t0, not_win
		
		li $v0, 1
		restore_context
		jr $ra #return 1, jogador ganhou
		
		not_win:
		    li $v0, 0
		    restore_context
		    jr $ra #return 0, jogador não ganhou
		   
	
    #int checkVictory(int board[][SIZE]) {
        #int count = 0;
        #// Checks if the player has won
        #for (int i = 0; i < SIZE; ++i) {
            #for (int j = 0; j < SIZE; ++j) {
                #if (board[i][j] >= 0) {
                    #count++;
                #}
            #}
        #}
        #if (count < SIZE * SIZE - BOMB_COUNT)
            #return 0;
        #return 1; // All valid cells have been revealed
    #}	
		
	
	
	
	
	
