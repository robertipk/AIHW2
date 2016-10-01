# Robert Ip, CISC 3410, Program #2
# https://github.com/robertipk/AIHW2
require_relative 'utilities'
require_relative 'cell'
require_relative 'priorityq'


require 'pry'
class Board
  def initialize(string)
    @MRV_priorityQ = PriorityQueue.new
    @board = Array.new
    index = 0
    string_arr = string.split("")
    if string_arr.length != 81
      puts "Cannot intialize - incorrect input"
    else
      9.times do
        row = Array.new
        9.times do
          new_cell = Cell.new(string_arr[index])
          row.push(new_cell)
          index += 1
        end
        @board.push(row)
      end
    end
   # add constraints to the appropriate cells
    for x in 0...9
      for y in 0...9
        num = @board[x][y].value
        if num!=0
          neighbors = get_neighbors(x,y)
          neighbors.each do |cell|
            if cell==nil
              puts "this cell is nil" + x.to_s + y.to_s
            end
            cell.add_constraint(num)
          end
        end
      end
    end
  end

  #returns next cell off the min heap
  def next_cell
    @MRV_priorityQ.pop
  end

  def print
    @board.each do |row|
      row.each do |tile|
        p tile.value + " "
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

  # return the neighbors of the cell at the specified coordinates, including the cell itself
  def get_neighbors(x,y)
   neighbors = Array.new
   row = x
   column = y
   region_row = x/3
   region_col = y/3
   # add nieghbors in row
   for x in 0...9
     if @board[row][y]==nil
       puts "here"
       binding.pry
     end
     neighbors << @board[row][y]
   end
   # add neighbors in column
   for x in 0...9
     if @board[x][column]==nil
       puts "here"
       binding.pry
     end
     neighbors << @board[x][column]
   end
   # add neighbors in subregion
   for a in row-1...row+3
     for b in column-1...column+3
       if @board[a][b]==nil
         puts "here"
         binding.pry
       end
       neighbors << @board[a][b]
     end
   end
   neighbors
  end

  # minimum remaining value heuristic
  def MRV

  end
end
