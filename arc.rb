# Robert Ip, CISC 3410, Program #2

# when an arc is popped off the TDA queue, the domain of cell is revised like so:
# for each number Z in the domain of cell1, if there is not at least one value in the domain of cell2
# that is not Z, remove Z from the domain of cell1.
# the only way the domain of cell1 can be revised is if the domain of cell2 contains only one value
# i.e. cell2 must be already solved
class Arc
  attr_accessor :cell1,:cell2
  def initialize(cell1,cell2)
   @cell1 = cell1
   @cell2 = cell2
  end
end
