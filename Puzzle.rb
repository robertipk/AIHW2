# Robert Ip, CISC 3410, Program #2
# https://github.com/robertipk/AIHW2
require_relative 'utilities'
require_relative 'cell'
require_relative 'priorityq'
require_relative 'algorithms'



require 'pry'
class Board
  def initialize(string)
    @MRVheap = PriorityQueue.new
    @board = Array.new
    index = 0
    string_arr = string.split("")
    if string_arr.length != 81
      puts "Cannot intialize board - incorrect input"
    else
      for x in 0...9
        row = Array.new
        for y in 0...9
          new_cell = Cell.new(string_arr[index],x,y)
          row.push(new_cell)
          index += 1
        end
        @board.push(row)
      end
    end
   # add constraints to the appropriate cells
    for x in 0...9
      for y in 0...9
        num = @board[x][y].value.to_i
        if num!=0
          @MRVheap << @board[x][y]
          neighbors = get_neighbors(x,y)
          neighbors.each do |cell|
            cell.add_constraint(num)
          end
        end
      end
    end
  end

  #returns next cell off the min heap
  def next_cell
    @MRVheap.pop
  end

  def print_state
    @board.each do |row|
      row.each do |tile|
        print tile.value.to_s + " "
      end
      puts ""
    end
  end

  def is_complete?
    for x in 0...9
      for y in 0...9
        if @board[x][y]=="."
          return false
        end
      end
    end
    true
  end

  def is_solved?
    # checks all columns
    for x in 0...9
      arr = []
      for y in 0...9
        arr << @board[x][y].value
      end
      if !no_dups(arr)
        return false
      end
    end

    # checks all columns
    for x in 0...9
      arr = []
      for y in 0...9
        arr << @board[y][x].value
      end
      if !no_dups(arr)
        return false
      end
    end
    # check nine 3x3 regions
    if !check_all_regions
      return false
    end

    true
  end

  # given the coordinates of the upper left corner, validates 3 x 3 region
  def check_region(row,column)
    arr = []
    for x in row...row+3
      for y in column...column+3
        arr << @board[x][y].value
      end
    end
    if !no_dups(arr)
      return false
    end
    true
  end

  # check all 3x3 regions
  def check_all_regions
     if !check_region(0,0) || !check_region(0,3) || !check_region(0,6) ||
       !check_region(3,0) || !check_region(3,3) || !check_region(3,6) ||
       !check_region(6,0) || !check_region(6,3) || !check_region(6,6)
       return false
     end
     true
  end

  # return the neighbors of the cell at the specified coordinates
  # does NOT include the cell itself
  def get_neighbors(row,column)
   neighbors = Array.new
   region_row = 3*(row/3)
   region_col = 3*(column/3)
   # add nieghbors in row
   for p in 0...9
     unless column == p
      neighbors << @board[row][p]
     end
   end
   # add neighbors in column
   for d in 0...9
     unless row == d
      neighbors << @board[d][column]
     end
   end
   # add neighbors in subregion
   for a in region_row...region_row+3
     for b in region_col...region_col+3
       unless a == row && b == column
        neighbors << @board[a][b]
       end
     end
   end
   neighbors
  end

  # minimum remaining value heuristic
  def MRV

  end
end
