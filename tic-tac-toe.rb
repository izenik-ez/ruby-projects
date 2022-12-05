class Player
  attr_reader :name, :mark
  @@num = 0
  def initialize
    raise "No more than two players" if @@num > 2
    @@num+=1
    @name = "Player #{@@num}"
    if @@num == 1
      @mark = "X"
    else
      @mark = "O"
    end
  end

end

class Board
  
  def initialize
    @board = Array.new(3){Array.new(3, nil)}    
  end

  def move_allowed?(row, col)
    row < @board.length &&
    col < @board.length &&
    @board[row][col] == nil
  end
  
  def move(row, col, player)
    @board[row.to_i][col.to_i] = player
  end

  def ask_for_move (player)    
    puts "#{player.name}'s turn!" 
    move = [0,0]
    print "ROW: "
    move[0] = gets.chomp.to_i
    print "COLUMN: "
    move[1] = gets.chomp.to_i
    move
  end

  def show_board
    @board.each do |row|
      row.each do |square|
        print "| #{square.class == Player ? square.mark : " "} "
      end
      print "|\n"
    end
  end

  def complete_board?
    @board.all? do |row|
      row.all?{|square| square.class == Player}
    end
  end

  def complete_row? (player)
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
  
  def complete_column? (player)
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

  def complete_diagonal?(player)
    if diagonal1? player
      1
    elsif diagonal2? player
      2
    else
      false
    end
  end

  def winner?(player)
    if complete_row?(player) ||
       complete_column?(player) ||
       complete_diagonal?(player)
      true
    else
      false
    end
  end

  def winner
    if winner? @player1
      player1
    elsif winner? @player2
      player2
    else
      ""
    end
  end
end



board = Board.new
p1 = Player.new
p2 = Player.new

winner = false
row = "" 
column = ""

until board.complete_board?

  board.show_board
    
  begin
    movement = board.ask_for_move p1
  end  until board.move_allowed? movement[0].to_i, movement[1].to_i
  board.move movement[0], movement[1], p1
  if board.winner? p1
    puts "Player 1 WINS!"
    winner = true
    break
  end

  break if board.complete_board?    
  
  board.show_board
  
  begin
    movement = board.ask_for_move p2
  end until board.move_allowed? movement[0].to_i, movement[1].to_i
  board.move movement[0].to_i, movement[1].to_i, p2  
  
  if board.winner? p2
    puts "Player 2 WINS!"
    winner = true
    break
  end    
end# until board.complete_board?

puts "Nobody Wins!" unless winner

