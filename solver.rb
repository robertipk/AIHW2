# Robert Ip, CISC 3410, Program #2
require_relative 'algorithms'
require_relative 'cell'
require_relative 'puzzle'
require_relative 'arc'

input = File.read("puzzle.txt").split(" ")
num_solved = 0
time = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
backtracking_filename = "Puzzles_Solved_With_Backtracking_" + time
ac3_filename = "Puzzles_Solved_With_ac3_" + time
File.truncate('Puzzles_Solved_With_Backtracking', 0)
File.truncate('Puzzles_Solved_With_ac3', 0)

input.each do |line|
  board = Game.new(line)
  solve_with_backtracking(board,backtracking_filename)
end

input.each do |line|
  board = Game.new(line)
  ac3(board,ac3_filename)
end
