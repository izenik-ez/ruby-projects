class Board
  
  def initialize
    @board = Array.new(3){Array.new(3, nil)}
    @player1 = "X"
    @player2 = "O"
  end

  def board
    @board
  end

  def move(row, col, player)
    raise IndexError if row >= @board.length || col >= @board[0].length
    raise StandardError if @board[row][col] != nil
    @board[row][col] = player
  end

  def show_board
    @board.each do |row|
      row.each do |square|
        print "| #{square==nil ? " " : square} "
      end
      print "\n"
    end
  end

  #private  

  def any_row? (player)
    @board.each_with_index do |row, index|
      if row.all?{|square| square == player}
        return index
      end
    end
    false
  end

  def get_columns(column)
    columns = []
    @board.each do |row|
      columns << row[column]
    end
    columns
  end
  
  def any_column? (player)
    for i in 0..@board.length-1
      if get_columns(i).all?{|square| square == player}
        return i
      end
    end
    false
  end  

  def diagonal1?(player)
    if @board[0][0] == player &&
       @board[1][1] == player &&
       @board[2][2] == player
      true
    else
      false
    end
  end

  def diagonal2?(player)
    if @board[0][2] == player &&
       @board[1][1] == player &&
       @board[2][0] == player
      true
    else
      false
    end
  end

  def any_diagonal?(player)
    if diagonal1? player
      1
    elsif diagonal2? player
      2
    else
      false
    end
  end

  def winner?(player)
    if any_row?(player) ||
       any_column?(player) ||
       any_diagonal?(player)
      true
    else
      false
    end
  end
                
end
=begin
  

  def winner?(player)
    if any_row_player? player
       column_player?
  end
=end

board = Board.new

board.show_board

board.move(1,1,1)

board.show_board

board.move(1,0,1)

board.move(1,2,1)
puts board.any_row? 1
board.show_board
#puts board.row_player? 1,1

board = Board.new
board.move(0,0,1)
board.move(1,0,1)
board.move(2,0,1)
puts board.any_column? 1
board.show_board

board = Board.new
board.move(0,0,1)
board.move(1,1,1)
board.move(2,2,1)

puts board.diagonal1? 1
board.show_board

board = Board.new
board.move(0,2,1)
board.move(1,1,1)
board.move(2,0,1)

puts board.diagonal2? 1
board.show_board

puts board.winner? 1
puts board.winner? 2
