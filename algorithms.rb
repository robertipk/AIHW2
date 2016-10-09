# Robert Ip, CISC 3410, Program #2
require_relative 'puzzle'
require_relative 'arc'

# AC-3 algorithm
# TDA queue initially consists of all the arcs in the graph
# while the set is not empty, an arc (X,c) is removed from TDA and considered
# if the arc is not consistent, it is made consistent by pruning the domain of variable x
# all of the previously consistent arcs that could, as a result of pruning X, have become inconsistent are placed back into TDA
# these are the arcs (Z,X), where Z is a a neighbor of X
# in the case of sudoku, there are 20 neighbors for each cell
def ac3(sudoku,ac3_filename)
  non_tda = Array.new
  tda_queue = Array.new
  for x in 0...9
    for y in 0...9
      neighbors = sudoku.get_neighbors(x,y)
      neighbors.each do |cell|
        if sudoku.board[x][y].value==0 && sudoku.board[x][y].remaining_vals.length==1
          tda_queue << Arc.new(cell,sudoku.board[x][y])
        else
          non_tda << Arc.new(cell,sudoku.board[x][y])
        end
      end
    end
  end
  solve_with_ac3(tda_queue,non_tda,sudoku,ac3_filename)
end

def solve_with_ac3(tda_queue,non_tda,sudoku,filename)
  while !tda_queue.empty?
    arc = tda_queue.shift
    non_tda << arc
    sudoku.print_board(filename)
    if revise(arc)
      # the domain of arc[0] was reduced
      # find arcs of the form (X,arc[0]) on the non-TDA queue and add them to the TDA queue
      if arc.cell1.remaining_vals.length==1
        puts "should enque neighbors now"
        enque_neighbors(arc.cell1,non_tda,tda_queue)
      end
    end
  end
  # tda queue is now empty
  if sudoku.is_complete?
    if sudoku.is_solved?
      puts "Puzzle solved"
      open(filename, 'a') { |f|
        f.puts "PUZZLE SOLVED"
      }
      sudoku.print_board(filename)
    end
  end
  binding.pry
end

# backtracking using minimum remaining value heuristic
def solve_with_backtracking(sudoku,filename)
  if sudoku.is_complete?
    if sudoku.is_solved?
      puts "Puzzle solved"
      open(filename, 'a') { |f|
        f.puts "PUZZLE SOLVED"
      }
      sudoku.print_board(filename)
      return true
    end
  end
  # sudoku.print_board
  candidate = sudoku.next_cell
  if candidate==nil
    return false
  end
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
          # puts "CELL FAILED " + cell.x_coord.to_s + " " + cell.y_coord.to_s + " when value of " + candidate.value.to_s + " is placed at " + candidate.x_coord.to_s + " " + candidate.y_coord.to_s
          forward_checking_failed = true
        # this value doesn't work! we need to backtrack and try the next value in values_to_try
          break
        end
      end
    end

    if forward_checking_failed
      modified_cells.each do |neighbor|
        neighbor.undo_constraint(candidate.value)
      end
      candidate.value = 0
    elsif !forward_checking_failed
      # reheapify the entire heap
      updated_heap = PriorityQueue.new
      while sudoku.MRVheap.get_length > 1
        updated_heap << sudoku.MRVheap.pop
      end
      sudoku.MRVheap = updated_heap
      # puts "Just filled square " + candidate.x_coord.to_s + " " + candidate.y_coord.to_s + "    " + candidate.value.to_s
      # clear this cell's domain because it has been solved already
      candidate.remaining_vals.clear
      if !solve_with_backtracking(sudoku,filename)
        # backtrack this number. undo addition of constraints. restore the possibilites, minus value that just failed
        candidate.remaining_vals = original_RVs
        candidate.remaining_vals.delete(candidate.value.to_i)
        modified_cells.each do |neighbor|
          neighbor.undo_constraint(candidate.value)
        end
        updated_heap = PriorityQueue.new
        while sudoku.MRVheap.get_length > 1
          updated_heap << sudoku.MRVheap.pop
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


# return true iff we revise the domain of cell1
def revise(arc)
  revised = false
  cell1, cell2 = arc.cell1,arc.cell2
  if cell2.remaining_vals.length==1
    puts "filled cell with " + cell2.remaining_vals[0].to_s + "--------------------------------------------------------------------------"
    cell2.value = cell2.remaining_vals[0]
    # eliminate that value from domain one if it exists
    if cell1.remaining_vals.include?(cell2.remaining_vals[0])
     cell1.remaining_vals.delete(cell2.remaining_vals[0])
     revised = true
     if cell1.remaining_vals.length == 0
       # there is no solution to the CSP
       puts "ERROR! This cell no longer has a valid domain"
       exit
     elsif cell1.remaining_vals.length == 1
       cell1.value = cell1.remaining_vals[0].to_i
     end
   end
  end
  revised
end

# find arcs of the form (X,arc.cell1) on the non-TDA queue and add them to the TDA queue
# these arcs may have become inconsistent due to the reduction of the domain of arc.cell1
def enque_neighbors(revised_cell,non_tda,tda_queue)
  switched_cells = Array.new
  non_tda.each do |arc|
    # add arc (X,arc.cell1) back to TDA queue iff arc.cell1 equals the revised cell
    # and X has not been set yet
    if arc.cell2==revised_cell && arc.cell1.remaining_vals.length>1 && arc.cell1.value==0
      switched_cells << arc
      tda_queue << arc
      non_tda.delete(arc)
    end
  end
  puts "number of arcs moved from non_TDA to TDA queue " + switched_cells.length.to_s
end
