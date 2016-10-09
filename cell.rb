# Robert Ip, CISC 3410, Program #2
class Cell
  attr_accessor :value,:remaining_vals,:x_coord,:y_coord,:preset
  def initialize(value=0,x_coord,y_coord)
   @x_coord = x_coord
   @y_coord = y_coord
   @value = value
   @preset = false
   @remaining_vals = [1,2,3,4,5,6,7,8,9]
   if value != 0
     @remaining_vals = [value]
   end
  end

  # removes number from possible remaining values
  def add_constraint(number)
    @remaining_vals.delete(number)
  end

  def num_of_MRVs
    @remaining_vals.length
  end

  # adds number back to the possible remaining values
  def undo_constraint(number)
    if !@remaining_vals.include?(number)
      @remaining_vals << number
    end
  end

end
