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
    puts ""
    move = [0,0]
    print "     ROW: "
    move[0] = gets.chomp.to_i
    print "     COLUMN: "
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
end


class Game
  def initialize
    @board = Board.new
    @player1 = Player.new
    @player2 = Player.new
    @winner = false
    #@row    = -1
    #@column = -1
  end

  def player_move (p)
    movement = [-1,-1]
    begin
      movement = @board.ask_for_move p
    end until @board.move_allowed? movement[0].to_i, movement[1].to_i
    
    @board.move movement[0].to_i, movement[1].to_i, p
    
    if @board.winner? p
      puts "#{p.name} WINS"
      @winner = true
    end
  end

  def game_loop
    #until @board.complete_board?
    loop do
      @board.show_board

      player_move @player1
      break if @winner || @board.complete_board?

      @board.show_board
     # break if @board.complete_board?
      player_move @player2
      break if @winner || @board.complete_board?
    end
    puts "Nobody Wins!" unless @winner
  end  
end

g = Game.new
g.game_loop

