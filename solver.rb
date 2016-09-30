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
