class HangmanDraw
  attr_reader :moves
  def initialize
    @hangman = Array.new(6){Array.new(6," ")}
    @moves = 0
  end

  def wrong_guess
    @moves += 1
    case @moves
    when 1
      @hangman[0]=@hangman[0].map{|i| "-"}
      (@hangman.length).times{|i| @hangman[i][6] = "|"}
    when 2
      @hangman[2][2] = "O"
    when 3
      @hangman[3][2] = "|"
    when 4
      @hangman[3][1] = "/"
    when 5
      @hangman[3][3] = "\\"
    when 6
      @hangman[4][1] = "/"
    when 7
      @hangman[4][3] = "\\"
    when 8
      @hangman[1][2] = "|"
    end
    draw
  end

  def draw
    @hangman.each do |row|
      row.each{|r| print r}
      puts
    end
  end
  
end

# h = Hangman.new

# 8.times{|i| h.add_move}

# puts "Moves #{h.moves}"
# h.draw


class SecretWord
  attr_reader :secret_word
  def initialize
    path = "google-10000-english-no-swears.txt"
    @dictionary = File.read(path).split
    @secret_word = select_random_word
  end

  private
  def create_hash
    @hash = @dictionary.reduce(Hash.new(0)) do |h, w|
      len = w.length
      h[len] = Array.new if h[len] == 0
      h[len] << w
      h
    end
    @hash
  end

  def select_random_word
    hash = create_hash
    len = rand(5..12)
    select_random_word(hash) if hash[len].nil?
    hash[len][rand(hash[len].length)]
  end
  
end


class Board
  def initialize
    @secret_word = SecretWord.new.secret_word
    @board = create_board
    @user_guess = ""
    @draw = HangmanDraw.new
  end

  def print_board
    @board.each_char{|c| print "#{c}"}
    puts
  end
  def user_move(round)
    print "#{round+1} Guess a letter > "
    @user_guess = gets.chomp.downcase
    puts
  end

  def play
    8.times do |round|      
      puts "CHEATER!! #{@secret_word}"
      user_move round
      if replace_letter_in_board.length == 0
        @draw.wrong_guess
      else
        @draw.draw
      end

      print_board
      if @board  == @secret_word
        return @secret_word
      end
    end
    nil
  end
  
  private
  def create_board
    len = @secret_word.length
    "_" * len
  end

  def search_string
    indexes = []
    i = 0
    @secret_word.each_char do |c|
      indexes << i if c == @user_guess
      i += 1
    end
    indexes
  end
  def replace_letter_in_board
    indexes = search_string #@user_guess, @secret_word
    indexes.each{|i| @board[i] = @user_guess}
    indexes
  end
end


b = Board.new
if b.play
  puts "You win! Secret Word: #{b.secret_word}"
else
  puts "You loose!"
end
