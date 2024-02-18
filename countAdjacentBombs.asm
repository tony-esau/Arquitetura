.include "macros.asm"

.globl countAdjacentBombs

countAdjacentBombs:
	save_context
	move $s0, $a0 #inicio da matriz
	move $s1, $a1 #índice da linha do elemento
	move $s2, $a2 #índice da coluna do elemento

  	li $s3, 0 #contador = 0
  
 	#Inicio e limite do laço i
  	subi $s4, $s1, 1 #i = row - 1
  	addi $s5, $s1, 1 #row + 1
  	
  	begin_for_i_it:
  	      bgt $s4, $s5, end_for_i_it  #fim do laço i
  
  	      #Inicio e limite do laço j
  	      subi $s6, $s2, 1 # j = column - 1
	      addi $s7, $s2, 1 #column + 1
	      
  	      begin_for_j_it:
  	            bgt  $s6, $s7, end_for_j_it  #fim do laço j
  
  	      li $t1, SIZE #SIZE = 8 = $t1
  	     
  	      blt $s4, $zero, j_increment_and_jump #i < 0
  	      bge $s4, $t1, j_increment_and_jump #i >= SIZE
  	      blt $s6, $zero, j_increment_and_jump #j < 0
  	      bge $s6, $t1, j_increment_and_jump #j >= SIZE
  
  	      sll $t1, $s4, 5 # Percorre linhas
  	      sll $t2, $s6, 2 # Percorre colunas
  	      add $t3, $t1, $t2
  	      add $t0, $t3, $s0
  	      
  	      lw $t1, 0($t0)#board[i][j] = $t1
  	      
  	      li $t4, -1 #-1 para comparação
  	      
  	      bne $t1, $t4, j_increment_and_jump #board[i][j] != -1
  
  	      addi $s3, $s3, 1 #contador++
  	      
  	      j_increment_and_jump:
  	        addi $s6, $s6, 1 #j++
  	        j begin_for_j_it
  
  	     end_for_j_it: #fim do laço j
  	         addi $s4, $s4, 1 #i++
  	         j begin_for_i_it
  
  	end_for_i_it:
  	move $v0, $s3
  	restore_context
  	jr $ra
  

  #int countAdjacentBombs(int board[][SIZE], int row, int column) {
       # // Counts the number of bombs adjacent to a cell
      #  int count = 0;
      #  for (int i = row - 1; i <= row + 1; ++i) {
       #     for (int j = column - 1; j <= column + 1; ++j) {
       #         if (i >= 0 && i < SIZE && j >= 0 && j < SIZE && board[i][j] == -1) {
         #           count++;
      #          }
          #  }
       # }
       # return count;
 #   }
 
