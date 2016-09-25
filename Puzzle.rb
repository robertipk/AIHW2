# Robert Ip, CISC 3410, Program #2
# https://github.com/robertipk/AIHW2
class Board
  def initialize(string)
    @board = Array.new
    index = 0
    if string.length != 81
      puts "Cannot intialize - incorrect input"
    else
      9.times do
        row = Array.new
        9.times do
          row.push(string[index])
          index += 1
        end
        @board.push(row)
    end
  end

  def print_board
    @board.each do |row|
      row.each do |tile|
        p tile.to_s + " "
      end
    end
  end

  def is_complete
    for x in 0...9
      for y in 0...9
        if @board[x][y]=="."
          return false
        end
      end
    end
    true
  end

  def is_solved

  end




end
