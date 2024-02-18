.include "macros.asm"

.data
	msg_row:  		.asciiz "Enter the row for the move: "
 	msg_column:  	.asciiz "Enter the column for the move: "
 	msg_win:  		.asciiz "Congratulations! You won!\n"
 	msg_lose:  		.asciiz "Oh no! You hit a bomb! Game over.\n"
	msg_invalid:  .asciiz "Invalid move. Please try again.\n"

.globl main 	 	
.text

main:
  addi $sp, $sp, -256 	# board; 
  li $s1, 1	     				# int gameActive = 1;
  move $s0, $sp
  move $a0, $s0 
  
  jal initializeBoard # initializeBoard(board);
  move $a0, $s0 				
  jal plantBombs 				 # placeBombs(board);
  
  begin_while:					 # while (gameActive) {
  beqz $s1, end_while
  move $a0, $s0 
  li $a1, 0
  jal printBoard				 # printBoard(board,0); // Shows the board without bombs
  
  la $a0, msg_row		
  li $v0, 4							# printf("Enter the row for the move: ");
  syscall
  
  li $v0, 5  						# scanf("%d", &row);
  syscall
  move $s2, $v0
  
  la $a0, msg_column
  li $v0, 4 						# printf("Enter the column for the move: ");
  syscall
  
  li $v0, 5 						# scanf("%d", &column);

  syscall
  move $s3, $v0 
  
  li $t0, SIZE
  blt $s2, $zero, else_invalid	#if (row >= 0 && row < SIZE && column >= 0 && column < SIZE) {
  bge $s2, $t0, else_invalid		
  blt $s3, $zero, else_invalid
  bge $s3, $t0, else_invalid
  
  addi $sp, $sp, -4
  sw $s0, 0 ($sp)
  move $a0, $s2
  move $a1, $s3
  jal play
  addi $sp, $sp, 4
  bne $v0, $zero, else_if_main 	# if (!play(board, row, column)) {
    li $s1, 0										# gameActive = 0;
  la $a0, msg_lose							# printf("Oh no! You hit a bomb! Game over.\n");
  li $v0, 4
  syscall
  j end_if_main
  
 else_if_main:
 	move $a0, $s0
  jal checkVictory							# else if (checkVictory(board)) {
  beq $v0, $zero, end_if_main
  la $a0, msg_win								# printf("Congratulations! You won!\n");
  li $v0, 4
  syscall
  li $s1, 0											# gameActive = 0; // Game ends
  j end_if_main 
  else_invalid:		
  la $a0, msg_invalid						# printf("Invalid move. Please try again.\n");
  li $v0, 4
  syscall
  end_if_main:
  j begin_while
  end_while:
  move $a0, $s0 
  li $a1, 1
  jal printBoard								# printBoard(board,1);
  li $v0, 10
  syscall

