# Robert Ip, CISC 3410, Program #2
# https://github.com/robertipk/AIHW2
require_relative 'algorithms'
require_relative 'cell'
require_relative 'algorithms'
require_relative 'puzzle'

# input = File.read("puzzle.txt")
# sudoku = Board.new(input)
# ac3(sudoku)
# backtrack(sudoku)

solved_board=[[9,6,3,1,7,4,2,5,8],
[1,7,8,3,2,5,6,4,9],
[2,5,4,6,8,9,7,3,1],
[8,2,1,4,3,7,5,9,6],
[4,9,6,8,5,2,3,1,7],
[7,3,5,9,6,1,8,2,4],
[5,8,9,7,1,3,4,6,2],
[3,1,7,2,4,6,9,8,5],
[6,4,2,5,9,8,1,7,3]]

solved_string = "9,6,3,1,7,4,2,5,8,1,7,8,3,2,5,6,4,9,2,5,4,6,8,9,7,3,1,8,2,1,4,3,7,5,9,6,4,9,6,8,5,2,3,1,7
,7,3,5,9,6,1,8,2,4,5,8,9,7,1,3,4,6,2,3,1,7,2,4,6,9,8,5,6,4,2,5,9,8,1,7,3"
sample_string = "003020600900305001001806400008102900700000008006708200002609500800203009005010300"
board = Game.new(sample_string)
board.print_board
solve_with_backtracking(board)
