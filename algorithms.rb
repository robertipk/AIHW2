# Robert Ip, CISC 3410, Program #2
# https://github.com/robertipk/AIHW2
require_relative 'puzzle'

# AC-3 algorithm
def ac3

end

# backtracking using minimum remaining value heuristic
def solve_with_backtracking(sudoku)
  # select cell with MRV off the min heap
  candidate = sudoku.next_cell
  values_to_try = Array.new
  candidate.get_RVs.each do |value|
    values_to_try << value
  end
  forward_checking_fails = false
  neighbors = sudoku.get_neighbors(candidate.x_coord,candidate.y_coord)
  # now try each of the remaining values
  # if that value doesn't work, try again with the next value
  while !values_to_try.empty?
    candidate.value = values_to_try[0].to_i
    # check if the board is complete
    if sudoku.is_complete?
      if sudoku.is_solved?
        binding.pry
        puts "The board is solved!"
        sudoku.print
        return true
      end
    end
  # forward checking to reduce neighbors' domains
    neighbors.each do |cell|
      cell.add_constraint(candidate.value)
      if cell.num_of_MRVs == 0
        # if forward checking reduces all values for a neighbor, backtrack
        neighbors.each do |neighbor|
          neighbor.undo_constraint(candidate.value)
        end
        # reset cell's value to empty
        candidate.value = 0
        values_to_try.shift
        forward_checking_fails = true
        break
      end
    end
  # at this point, no contradictions were found when doing forward checking
  # now recurse
  puts "Cell" + candidate.x_coord.to_s + " " + candidate.y_coord.to_s + " " + candidate.value.to_s
  puts "trying next number"
    if solve_with_backtracking(sudoku)
      return
    end
  end
  # if method reaches this block, all values have been tried unsuccessfully
  false
end
