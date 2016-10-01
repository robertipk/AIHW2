# Robert Ip, CISC 3410, Program #2
# https://github.com/robertipk/AIHW2
require_relative 'puzzle'
# AC-3 algorithm
def ac3

end

# backtracking using minimum remaining value heuristic
def solve_with_backtracking(sudoku)
  sudoku.print_board
  binding.pry

  puts ""
  candidate = sudoku.next_cell
  if candidate==nil
    # binding.pry
  end
  values_to_try = candidate.remaining_vals.dup
  forward_checking_failed = false
  neighbors = sudoku.get_neighbors(candidate.x_coord,candidate.y_coord)
  # now try each of the remaining values
  while !values_to_try.empty?
    candidate.value = values_to_try.shift
    # check if the board is complete
    if sudoku.is_complete?
      if sudoku.is_solved?
        binding.pry
      end
    end
  # forward checking to reduce neighbors' domains
    neighbors.each do |cell|
      cell.add_constraint(candidate.value)
      if cell.num_of_MRVs == 0 && !cell.preset
        forward_checking_failed = true
        # this value doesn't work! we need to backtrack and try the next value in values_to_try
        break
      end
    end

    if forward_checking_failed
      puts "forward checking failed"
      neighbors.each do |neighbor|
        # RIGHT NOW IT"S ADDING CONSTRAINTS TO ALLLLL NEIGHBORS> FIX THIS
        neighbor.undo_constraint(candidate.value)
      end
      candidate.value = 0
    else
      # recurse - move on to fill in next square
      puts "Just filled square " + candidate.x_coord.to_s + " " + candidate.y_coord.to_s + "    " + candidate.value.to_s
      if !solve_with_backtracking(sudoku)
        # backtrack this number. undo addition of constraints
        neighbors.each do |neighbor|
          neighbor.undo_constraint(candidate.value)
        end
      end
    end
  end
  # if method reaches this block, all values have been tried unsuccessfully
  # return the cell to the min heap IN ITS ORIGINAL STATE, then return false
  candidate.value = 0
  sudoku.MRVheap << candidate
  false
end
