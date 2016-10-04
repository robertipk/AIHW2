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
  cell1, cell2 = arc[0],arc[1]
  cell2.each do |number|
   # prune the domain of domain_one
   if cell1.remaining_vals.include?(number)
     cell1.remaining_vals.delete(number)
     reduced_domain = true
     if cell1.remaining_vals.length == 0
       # there is no solution to the CSP
       puts "ERROR! This cell no longer has a valid domain"
       exit
  end
  reduced_domain
end

# place arcs that may have become inconsistent back onto the TDA queue
def enque_neighbors(variable,non_TDA,TDA)

end

def ac3(board)
  non_TDA,TDA = Array.new,Array.new
  # load all arcs into TDA queue
  for x in 0...board.length
    for y in 0...board[0].length
      neighbors = get_neighbors(board[x][y])
      neighbords.each do |cell|
        TDA << Arc.new(board[x][y],cell)
    end
  end
  solve_with_ac3(TDA,non_TDA,board)
end
# TDA queue initially consists of all the arcs in the graph
# while the set is not empty, an arc (X,c) is removed from TDA and considered
# if the arc is not consistent, it is made consistent by pruning the domain of variable x
# all of the previously consistent arcs that could, as a result of pruning X, have become inconsistent are placed back into TDA
# these are the arcs (Z,c'), where c' is a different constraint than c that involves X, and Z is a variable
# involves in c' other than X
def solve_with_ac3(TDA,non_TDA,board)
  while !TDA.empty?
    arc = TDA.shift
    if removed_inconsistent_values(arc)
      enque_neighbors(arc[0],non_TDA,TDA)
    end
  end
end
