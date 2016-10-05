# Robert Ip, CISC 3410, Program #2
# https://github.com/robertipk/AIHW2
require_relative 'algorithms'
require_relative 'cell'
require_relative 'algorithms'
require_relative 'puzzle'
require_relative 'arc'

require 'pry'

# input = File.read("puzzle.txt").split(" ")
# num_solved = 0
# input.each do |line|
#   board = Game.new(line)
#   board.print_board
#   if solve_with_backtracking(board)
#     num_solved+=1
#   end
# end
# puts "number of puzzles solved: " + num_solved.to_s



# sudoku = Board.new(input)
# ac3(sudoku)
# backtrack(sudoku)

# solved_board=[[9,6,3,1,7,4,2,5,8],
# [1,7,8,3,2,5,6,4,9],
# [2,5,4,6,8,9,7,3,1],
# [8,2,1,4,3,7,5,9,6],
# [4,9,6,8,5,2,3,1,7],
# [7,3,5,9,6,1,8,2,4],
# [5,8,9,7,1,3,4,6,2],
# [3,1,7,2,4,6,9,8,5],
# [6,4,2,5,9,8,1,7,3]]
#
# solved_string = "9,6,3,1,7,4,2,5,8,1,7,8,3,2,5,6,4,9,2,5,4,6,8,9,7,3,1,8,2,1,4,3,7,5,9,6,4,9,6,8,5,2,3,1,7
# ,7,3,5,9,6,1,8,2,4,5,8,9,7,1,3,4,6,2,3,1,7,2,4,6,9,8,5,6,4,2,5,9,8,1,7,3"
# sample_string = "007020000904650000000403000300000091700906030000000005005000800020080007008001050"
# sample_string2 = "000260701680070090190004500820100040004602900050003028009300074040050036703018000"
sample_string3 = "000100702030950000001002003590000301020000070703000098800200100000085060605009000"
#
board = Game.new(sample_string3)
board.print_board
# solve_with_backtracking(board)
ac3(board)
