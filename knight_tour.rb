require "tree"

class KnightTour

  attr_accessor :tree
  attr_accessor :solutions_found

  def initialize
  # Let's put the knight in 0,0 (top left)
    board = Board.new(0, 0)
    @tree = Tree.new(board)
    @solutions_found = 0
  end

  def start
    self.move(@tree)
  end

  def move(node)
    matrix = node.board.matrix
    next_move_number = node.board.move_number + 1

    if node.board.won?
      we_won!(node)
      return
    end

    # Horses can jump in eight possible ways
    moves = [
      [+1, +2],
      [-1, +2],
      [+1, -2],
      [-1, -2],

      [+2, +1],
      [-2, +1],
      [+2, -1],
      [-2, -1],
    ]

    # Calculate all possible moves for this node
    for x in 0..matrix.length - 1
      for y in 0..matrix[x].length - 1
        if matrix[x][y] == "KK"
          # Try every possible move...
          for i in 0..moves.length - 1
            new_x = x + moves[i][0]
            new_y = y + moves[i][1]

            # ... and if it's valid...
            # ...inside the board...
            if (new_x >= 0 and new_y >= 0 and new_x <= node.board.max_x and new_y <= node.board.max_y)
              # ...not previously moved there...
              if matrix[new_x][new_y] == "OO"
                # then the move is valid, so I clone the board
                board_clone = node.board.clone
                # mark the previous square...
                board_clone.matrix[x][y] = node.board.move_number.to_s
                # ... store the knight in the new position ...
                board_clone.matrix[new_x][new_y] = "KK"
                # ... create a new leaf ...
                leaf = Tree.new(board_clone)
                # ... and add this leaf to the previous node
                node.children << leaf
              end
            end
          end

        end         
      end
    end

    # If we have additional moves, let's move!
    node.children.each do |leaf|
      self.move(leaf)
    end
    # Note that, if we don't have any additional moves, this will...
    # ...just do nothing and backtrack

  end

  def we_won!(node)
    @solutions_found += 1
    puts "I found the solution #{@solutions_found}"
    node.board.print
  end
end