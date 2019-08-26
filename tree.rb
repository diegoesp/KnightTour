require "board"

class Tree
  attr_accessor :children, :board

  def initialize(board)
    @board = board
    @children = []
  end
end