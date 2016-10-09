# Robert Ip, CISC 3410, Program #2
require_relative 'puzzle'
require_relative 'cell'
class PriorityQueue
  attr_accessor :elements
  def initialize
    @elements = [nil]
  end

  def contains?(tile)
    @elements.include?(tile)
  end

  def get_length
    @elements.length
  end

  def getElements
    @elements
  end

  def empty?
    if @elements.length == 1
      return true
    end
    false
  end

  def <<(element)
    @elements << element
    # bubble up the element that we just added
    bubble_up(@elements.size - 1)
  end

  # implements min heap by comparing based on number of possibilities remaining
  def bubble_up(index)
    parent_index = (index / 2)

    # return if we reach the root element
    return if index <= 1

    # or if the parent is already less than the child
    return if @elements[parent_index].num_of_MRVs <= @elements[index].num_of_MRVs

    # otherwise we exchange the child with the parent
    exchange(index, parent_index)

    # and keep bubbling up
    bubble_up(parent_index)
  end

  def exchange(source, target)
    @elements[source], @elements[target] = @elements[target], @elements[source]
  end

  def pop
    # exchange the root with the last element
    exchange(1, @elements.size - 1)

    # remove the last element of the list
    max = @elements.pop

    # and make sure the tree is ordered again
    bubble_down(1)
    max
  end

  def bubble_down(index)
    child_index = (index * 2)

    # stop if we reach the bottom of the tree
    return if child_index > @elements.size - 1

    # make sure we get the largest child
    not_the_last_element = child_index < @elements.size - 1
    left_element = @elements[child_index]
    right_element = @elements[child_index + 1]
    child_index += 1 if not_the_last_element && right_element.num_of_MRVs < left_element.num_of_MRVs

    # there is no need to continue if the parent element is already bigger
    # then its children
    return if @elements[index].num_of_MRVs <= @elements[child_index].num_of_MRVs

    exchange(index, child_index)

    # repeat the process until we reach a point where the parent
    # is larger than its children
    bubble_down(child_index)
  end

  # debugging method. counts number of cells with only one remaining value in the domain
  def one_rv
   count = 0
   for x in 1...@elements.length
     if @elements[x].remaining_vals.length == 1
       count+=1
     end
   end
   count
  end
end

# testing the priority queue
# pq = PriorityQueue.new
# cell1 = Cell.new(1,3,4)
# cell1.remaining_vals = [1]
# cell2 = Cell.new(2,3,4)
# cell2.remaining_vals = [1,2]
# cell3 = Cell.new(3,3,4)
# cell3.remaining_vals = [1,2,3,4,5]
# cell4 = Cell.new(4,3,4)
# cell4.remaining_vals = [1,2,3,4,5,6,7,8]
# cell5 = Cell.new(5,3,4)
# cell5.remaining_vals = [1,2,3,4]
# cell6 = Cell.new(6,3,4)
# cell6.remaining_vals = [1]
# cell7 = Cell.new(7,3,4)
# cell7.remaining_vals = [1]
# cell8 = Cell.new(8,3,4)
# cell8.remaining_vals = [1]
#
# pq << cell1
# pq << cell2
# pq << cell3
# pq << cell4
# pq << cell5
# pq << cell6
# pq << cell7
# pq << cell8
# binding.pry
