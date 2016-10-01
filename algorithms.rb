# Robert Ip, CISC 3410, Program #2
# https://github.com/robertipk/AIHW2
require_relative 'puzzle'

# AC-3 algorithm
def ac3

end

# backtracking using minimum remaining value heuristic
def backtrack
  # select cell with MRV off the min heap
  candidate = board.next_cell
  must_backtrack = false
  neighbors = candidate.get_neighbors
  # forward checking to reduce neighbors' domains
  neighbors.each do |cell|
    cell.add_constraint(number)
    if cell.num_of_MRVs == 0
      # this neighboring is out of options. Need to undo adding of constraints
      break
      must_backtrack = true
    end
  end

  if must_backtrack
    # undo adding of constraints
    neighbors.each do |cell|
      cell.undo_constraint(number)
      return false
    end
    # try with another number? put back on the priority queue?
  end

  if @board.is_complete?
    if @board.is_solved?
      puts "The board is solved!"
      @board.print
      return true
    end
  end

  # if no cells have been invalidated, recurse by moving on and solving the next cells
  # if there is no solution, need to backtrack
  if backtrack == false
    return false
  end
end

# remaining value heuristic
def rvh

end
