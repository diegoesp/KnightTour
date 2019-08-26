class Board
  attr_accessor :matrix
  attr_accessor :move_number

  def initialize(initial_position_x = 0, initial_position_y = 0)

    # Algorithm works with any board. This is the template board
    @matrix = [
      ["OO", "OO", "OO", "OO", "OO"],
      ["OO", "OO", "OO", "OO", "OO"],
      ["OO", "OO", "OO", "OO", "OO"],
      ["OO", "OO", "OO", "OO", "OO"],
      ["OO", "OO", "OO", "OO", "OO"],
    ]

    @matrix[initial_position_x][initial_position_y] = "KK"

    @move_number = 1
  end

  def max_x
    @matrix[0].length - 1
  end

  def max_y
    @matrix.length - 1
  end

  # Creates another copy of the board with the exact same history and status
  def clone
    board_clone = Board.new
    for x in 0..@matrix.length - 1
      for y in 0..@matrix[x].length - 1
        board_clone.matrix[x][y] = @matrix[x][y]
      end
    end
    board_clone.move_number = self.move_number + 1
    board_clone
  end

  # Returns true if this board has a knight that covered all jumps
  def won?
    for x in 0..@matrix.length - 1
      for y in 0..@matrix[x].length - 1
        return false if @matrix[x][y] == "OO"
      end
    end

    true
  end

  # Prints the board to stdout
  def print
    board_print = ""

    for x in 0..@matrix.length - 1
      for y in 0..@matrix[x].length - 1
        if @matrix[x][y] == "KK"
          board_print << @matrix[x][y]
        else
          board_print << format('%02d', @matrix[x][y]).to_s
        end

        board_print << " "
      end

      board_print << "\n"
    end

    board_print << "\n"
    puts board_print
  end

end