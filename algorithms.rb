# Robert Ip, CISC 3410, Program #2
# https://github.com/robertipk/AIHW2
require_relative 'puzzle'
# AC-3 algorithm
def ac3

end

# backtracking using minimum remaining value heuristic
def solve_with_backtracking(sudoku)
  # check if the board is complete
  if sudoku.is_complete?
    if sudoku.is_solved?
      binding.pry
      return true
    end
  end
  sudoku.print_board
  candidate = sudoku.next_cell
  values_to_try = candidate.remaining_vals.dup
  forward_checking_failed = false
  neighbors = sudoku.get_neighbors(candidate.x_coord,candidate.y_coord)
  # now try each of the remaining values
  while !values_to_try.empty?
    candidate.value = values_to_try.shift
    original_RVs = values_to_try.dup
    modified_cells = Array.new
  # forward checking to reduce neighbors' domains
    neighbors.each do |cell|
      if cell.remaining_vals.include?(candidate.value) && !cell.preset
        cell.add_constraint(candidate.value)
        modified_cells << cell
        if cell.num_of_MRVs == 0 && !cell.preset
          puts "CELL FAILED " + cell.x_coord.to_s + " " + cell.y_coord.to_s + " when value of " + candidate.value.to_s + " is placed at " + candidate.x_coord.to_s + " " + candidate.y_coord.to_s
          forward_checking_failed = true
        # this value doesn't work! we need to backtrack and try the next value in values_to_try
          break
        end
      end
    end

    if forward_checking_failed
      puts "forward checking failed"
      modified_cells.each do |neighbor|
        neighbor.undo_constraint(candidate.value)
      end
      candidate.value = 0
    elsif !forward_checking_failed
      # reheapify the entire heap
      puts "Just filled square " + candidate.x_coord.to_s + " " + candidate.y_coord.to_s + "    " + candidate.value.to_s
      # clear this cell's domain because it has been solved already
      candidate.remaining_vals.clear
      if !solve_with_backtracking(sudoku)
        # backtrack this number. undo addition of constraints. restore the possibilites, minus value that just failed
        candidate.remaining_vals = original_RVs
        candidate.remaining_vals.delete(candidate.value.to_i)
        modified_cells.each do |neighbor|
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
