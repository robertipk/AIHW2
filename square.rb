# Robert Ip, CISC 3410, Program #2
# https://github.com/robertipk/AIHW2
class Square
  attr_accessor :value,:x_coord,:y_coord,:constraints
  def initialize(value=".",xcoord,ycoord,)
   @value = value
   @x_coord = xcoord
   @y_coord = ycoord
   @constraints = Array.new
  end

end
