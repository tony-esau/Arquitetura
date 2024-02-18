    /*
    * minesweeper.c
    *
    * Minesweeper Game Implementation
    * Created by: Ramon Nepomuceno
    * Professor of Computer Science
    * Federal University of Cariri (UFCA)
    *
    * This code is developed for the Computer Architecture course during the 2023.2 semester.
    *
    * Description:
    *   - The program implements a console-based Minesweeper game.
    *   - Players can reveal cells and avoid hitting bombs to win the game.
    *   - Developed as a practical exercise for learning computer architecture concepts.
    *
    * File Structure:
    *   - The code includes functions for initializing the board, placing bombs, printing the board,
    *     counting adjacent bombs, revealing adjacent cells, playing the game, and checking for victory.
    *
    * Usage:
    *   - Compile the code using a C compiler, such as GCC.
    *   - Run the compiled executable to play the Minesweeper game in the console.
    *
    * Note: This code was created by Ramon Nepomuceno for educational purposes.
    * Feel free to modify and distribute it for educational use.
    *
    * 
    */

    #include <stdio.h>
    #include <stdlib.h>
    #include <time.h>

    #define SIZE 8
    #define BOMB_COUNT 10

    void initializeBoard(int board[][SIZE]) {
        // Initializes the board with zeros
        for (int i = 0; i < SIZE; ++i) {
            for (int j = 0; j < SIZE; ++j) {
                board[i][j] = -2; // -2 means no bomb
            }
        }
    }

    void placeBombs(int board[][SIZE]) {
        srand(time(NULL));
        // Places bombs randomly on the board
        for (int i = 0; i < BOMB_COUNT; ++i) {
            int row, column;
            do {
                row = rand() % SIZE;
                column = rand() % SIZE;
            } while (board[row][column] == -1);
            board[row][column] = -1; // -1 means bomb present
        }
    }

    void printBoard(int board[][SIZE], int showBombs) {
        // Prints the board
        printf("    ");
        for (int j = 0; j < SIZE; ++j)
            printf(" %d ", j);
        printf("\n");
        printf("    ");
        for (int j = 0; j < SIZE; ++j)
            printf("___");
        printf("\n");
        for (int i = 0; i < SIZE; ++i) {
            printf("%d | ", i);
            for (int j = 0; j < SIZE; ++j) {
                if (board[i][j] == -1 && showBombs) {
                    printf(" * "); // Shows bombs
                } else if (board[i][j] >= 0) {
                    printf(" %d ", board[i][j]); // Revealed cell
                } else {
                    printf(" # ");
                }
            }
            printf("\n");
        }
    }

    int countAdjacentBombs(int board[][SIZE], int row, int column) {
        // Counts the number of bombs adjacent to a cell
        int count = 0;
        for (int i = row - 1; i <= row + 1; ++i) {
            for (int j = column - 1; j <= column + 1; ++j) {
                if (i >= 0 && i < SIZE && j >= 0 && j < SIZE && board[i][j] == -1) {
                    count++;
                }
            }
        }
        return count;
    }

    void revealAdjacentCells(int board[][SIZE], int row, int column) {
        // Reveals the adjacent cells of an empty cell
        for (int i = row - 1; i <= row + 1; ++i) {
            for (int j = column - 1; j <= column + 1; ++j) {
                if (i >= 0 && i < SIZE && j >= 0 && j < SIZE && board[i][j] == -2) {
                    int x = countAdjacentBombs(board, i, j); // Marks as revealed
                    board[i][j] = x;
                    if (!x)
                        revealAdjacentCells(board, i, j); // Continues the revelation recursively
                }
            }
        }
    }

    int play(int board[][SIZE], int row, int column) {
        // Performs the move
        if (board[row][column] == -1) {
            return 0; // Player hit a bomb, game over
        }
        if (board[row][column] == -2) {
            int x = countAdjacentBombs(board, row, column); // Marks as revealed
            board[row][column] = x;
            if (!x)
                revealAdjacentCells(board, row, column); // Reveals adjacent cells
        }
        return 1; // Game continues
    }

    int checkVictory(int board[][SIZE]) {
        int count = 0;
        // Checks if the player has won
        for (int i = 0; i < SIZE; ++i) {
            for (int j = 0; j < SIZE; ++j) {
                if (board[i][j] >= 0) {
                    count++;
                }
            }
        }
        if (count < SIZE * SIZE - BOMB_COUNT)
            return 0;
        return 1; // All valid cells have been revealed
    }

    int main() {
        int board[SIZE][SIZE];
        int gameActive = 1;
        int row, column;

        initializeBoard(board);
        placeBombs(board);

        while (gameActive) {
            printBoard(board,0); // Shows the board without bombs

            // Asks the player to enter the move
            printf("Enter the row for the move: ");
            scanf("%d", &row);
            printf("Enter the column for the move: ");
            scanf("%d", &column);

            // Checks the move
            if (row >= 0 && row < SIZE && column >= 0 && column < SIZE) {
                if (!play(board, row, column)) {
                    gameActive = 0;
                    printf("Oh no! You hit a bomb! Game over.\n");
                } else if (checkVictory(board)) {
                    printf("Congratulations! You won!\n");
                    gameActive = 0; // Game ends
                }
            } else {
                printf("Invalid move. Please try again.\n");
            }
        }

        // Shows the final board with bombs
        printBoard(board,1);

        return 0;
    }
