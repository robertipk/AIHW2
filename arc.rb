require_relative 'utilities'
require_relative 'cell'
require_relative 'priorityq'
require_relative 'algorithms'
require 'pry'

class Arc
  # constraint - if a value is present in domain 2, remove it from domain 1
  attr_accessor :cell1,:cell2
  def initialize(cell1,cell2)
   @cell1 = cell1
   @cell2 = cell2
  end
end

# any values that are present in domain_one should be removed from domain_two
def removed_inconsistent_values(arc)
  reduced_domain = false
  cell1, cell2 = arc.cell1,arc.cell2
  cell2.remaining_vals.each do |number|
   # prune the domain of domain_one
   if cell1.remaining_vals.include?(number)
     cell1.remaining_vals.delete(number)
     puts "reduced the domain"
     reduced_domain = true
     if cell1.remaining_vals.length == 0
       # there is no solution to the CSP
       binding.pry
       puts "ERROR! This cell no longer has a valid domain"
       exit
     elsif cell1.remaining_vals.length == 1
       cell1.value = cell1.remaining_vals[0].to_i
     end
   end
  end
  reduced_domain
end

# find arcs of the form (X,arc[0]) on the non-TDA queue and add them to the TDA queue
# these arcs may have become inconsistent due to the reduction of the domain of arc[0]
def enque_neighbors(variable,non_tda,tda_queue)
  switched_cells = Array.new
  non_tda.each do |arc|
    if arc.cell2==variable
      switched_cells << arc
      tda_queue << arc
    end
  end
  puts "number of arcs moved from non_TDA to TDA queue " + switched_cells.length.to_s
  # need a comparator for this?
  # delete these cells from non_TDA
  switched_cells.each do |arc|
    non_tda.delete(arc)
  end
end

def ac3(sudoku)
  non_tda = Array.new
  tda_queue = Array.new
  # load all 1944 arcs (81x24) into TDA queue
  for x in 0...9
    for y in 0...9
      neighbors = sudoku.get_neighbors(x,y)
      neighbors.each do |cell|
        tda_queue << Arc.new(sudoku.board[x][y],cell)
      end
    end
  end
  solve_with_ac3(tda_queue,non_tda,sudoku)
end

# TDA queue initially consists of all the arcs in the graph
# while the set is not empty, an arc (X,c) is removed from TDA and considered
# if the arc is not consistent, it is made consistent by pruning the domain of variable x
# all of the previously consistent arcs that could, as a result of pruning X, have become inconsistent are placed back into TDA
# these are the arcs (Z,c'), where c' is a different constraint than c that involves X, and Z is a variable
# involves in c' other than X
def solve_with_ac3(tda_queue,non_tda,board)
  while !tda_queue.empty?
    tda_queue = tda_queue.sort do |arc1,arc2|
      case
      when arc1.cell2.remaining_vals.length < arc2.cell2.remaining_vals.length
        -1
      when arc1.cell2.remaining_vals.length > arc2.cell2.remaining_vals.length
        1
      else
        arc2.cell2.remaining_vals.length <=> arc2.cell2.remaining_vals.length
      end
    end
    # select the arc where arc.cell2 has only one value in its remaining value. That MUST be cell2's value
    # restrict arc.cell1 based on that
    arc = tda_queue.shift
    non_tda << arc
    if removed_inconsistent_values(arc)
      # the domain of arc[0] was reduced
      # find arcs of the form (X,arc[0]) on the non-TDA queue and add them to the TDA queue
      enque_neighbors(arc.cell1,non_tda,tda_queue)
    end
  end
  board.print_board
end
