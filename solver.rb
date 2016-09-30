# Robert Ip, CISC 3410, Program #2
# https://github.com/robertipk/AIHW2
require_relative 'algorithms'
require_relative 'square'
require_relative 'algorithms'


require_relative 'puzzle'

# input = File.read("puzzle.txt")
# sudoku = Board.new(input)
# ac3(sudoku)
# backtrack(sudoku)



test_arr = [1,2,3,4,5,6,7,8,9]
test_arr2 = [1,2,3,4,5,6,7,88,9]

puts no_dups(test_arr)
puts no_dups(test_arr2)

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
board = Board.new(solved_string)
board.print
puts board.is_solved?
puts board.is_complete?
