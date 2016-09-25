# Robert Ip, CISC 3410, Program #2
# https://github.com/robertipk/AIHW2

require_relative 'Puzzle'
require_relative 'algorithms'

input = File.read("puzzle.txt")
sudoku = Puzzle.new(input)
ac3(sudoku)
backtrack(sudoku)
