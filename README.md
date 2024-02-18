# Projeto Minesweeper MIPS

Este projeto implementa o jogo Minesweeper em linguagem Assembly MIPS, dividindo o código em vários arquivos para facilitar a organização. Cada funcionalidade do jogo está contida em um arquivo separado.

## Estrutura do Repositório

- **main.asm**: Contém a função principal (main) que controla o fluxo do jogo em Assembly MIPS.
- **printboard.asm**: Implementa a função para imprimir o tabuleiro.
- **initializeboard.asm**: Implementa a função para inicializar o tabuleiro.
- **plantbombs.asm**: Implementa a função para posicionar as bombas no tabuleiro.
- **macros.asm**: Contém macros úteis para facilitar o desenvolvimento em MIPS.
- **Mars.jar**: Executável do Mars MIPS, necessário para rodar os arquivos .asm.

- **minesweeper.c**: Contém a implementação em C do jogo Minesweeper. Este arquivo serve como referência para a lógica do jogo e pode ser utilizado para comparação com as implementações em Assembly MIPS.

- **play.asm**, **checkvictory.asm**, **revealcells.asm**: Arquivos em branco. Os alunos devem implementar essas funções em Assembly MIPS.

## Instruções de Execução

### Requisitos

O arquivo executável Mars.jar está incluído neste repositório.

### Execução do Código em C

1. Abra o terminal na pasta do repositório.
2. Compile o código C usando um compilador padrão C, como o GCC, com o seguinte comando:

   ```bash
   gcc minesweeper.c -o minesweeper
   ```
3. Execute o executável gerado:

   ```bash
   ./minesweeper
   ```
4. Siga as instruções no console para jogar o Minesweeper em C.

### Execução dos Arquivos em Assembly MIPS

1. Abra o terminal na pasta do repositório.
2. Execute o Mars MIPS digitando o seguinte comando:

   ```bash
   java -jar Mars.jar
   ```
3. No Mars MIPS, abra cada arquivo .asm individualmente e monte/executa o código. 
4. A saída do jogo será exibida na console do Mars MIPS.

### Observações

1. As macros no arquivo macros.asm foram criadas para simplificar o desenvolvimento e podem ser utilizadas conforme necessário.
2. Este projeto foi desenvolvido para a disciplina de Arquitetura de Computadores, período 2023.2, pelo professor Ramon Nepomuceno na UFCA.

Divirta-se jogando Minesweeper em Assembly MIPS!