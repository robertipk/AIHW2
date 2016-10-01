# Robert Ip, CISC 3410, Program #2
# https://github.com/robertipk/AIHW2
class Cell
  attr_accessor :value,:possibilities,:x_coord,:y_coord
  def initialize(value="0",x_coord,y_coord)
   @x_coord = x_coord
   @y_coord = y_coord
   @value = value
   @possibilities = [1,2,3,4,5,6,7,8,9]
  end

  # removes number from possible remaining values
  def add_constraint(number)
    # binding.pry
    @possibilities.delete(number)
  end

  def get_RVs
    @possibilities
  end

  # number of remaining values left
  def num_of_MRVs
    @possibilities.length
  end

  # adds number back to the possible remaining values
  def undo_constraint(number)
  
    if !@possibilites.include?(number)
      @possibilites << number
    end
  end

end
