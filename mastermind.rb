class Pegs

  attr_reader :colors
  
  def initialize(colors= ["Red", "Yellow", "Blue", "Orange", "Green", "Violet"])
    @colors = colors
  end

  def correct_position
    "W"
  end
  def correct_color
    "R"
  end

  def color?(color)
    @colors.include? color
  end
end
    
class Board  
  attr_reader :pegs, :secret_code,
              :size, :duplicates,
              :played_pegs,
              :checked_pegs
    
  
  def initialize(size, duplicates: false)
    @pegs = Pegs.new   
    @size = size
    @duplicates = duplicates
    @secret_code = generate_secret_code
    @played_pegs = []
    @checked_pegs = []
  end
  
  
  def add_played_pegs (pegs)
    @played_pegs << pegs
    add_checked_pegs(check_played_pegs pegs)
  end

  def add_checked_pegs (pegs)
    @checked_pegs << pegs
    @checked_pegs.last
  end

  def reset_board
    @secret_code = generate_secret_code
    @played_pegs = []
    @checked_pegs = []
  end

  def end_game?    
    @played_pegs.last == @secret_code
  end
  
  private
  
  def check_played_pegs (pegs)
    checked = Array.new(@size,nil)
   
    pegs.each_with_index do |peg, i|
      if peg == @secret_code[i]
        checked[i] = @pegs.correct_position
      elsif @secret_code.include? peg
        checked[i] = @pegs.correct_color
      end
    end
    checked
  end  

  def generate_secret_code
    secret_color_code = []
    color = ""
    @size.times do |i|      
      color = @pegs.colors[rand(@size)]      
      redo if @duplicates == false && secret_color_code.include?(color)
      secret_color_code << color
    end
    secret_color_code
  end      
end


class Interfaze
  def initialize (board)
    @board = board
  end
  def ask_for_color(total)
    played_pegs = []
    puts "Allowed colors: #{@board.pegs.colors}"
    total.times do |i|
      print "##{i+1}> "
      color_guess = gets.chomp.downcase.capitalize
      if @board.pegs.color? color_guess
        played_pegs[i] = color_guess
      else
        redo
      end
    end
    played_pegs
  end

  def print_pegs
    offset = 5
    # Get the longer color name and his length
    max_length = @board.pegs.colors.max{|color| color.length}.length    
    @board.played_pegs.last.each{|peg| print peg.center(max_length+offset)}
    puts
    @board.checked_pegs.last.each do |peg|
      if peg.nil?
        print (' ' * (max_length+offset))
      else
        print peg.center(max_length+offset)
      end
    end
    puts
  end

  def print_board
    @board.played_pegs.each_with_index do |pegs, i|
      unless @board.pegs.colors.any? nil
        print_pegs
        puts
      end      
    end
  end
  
  def end_banner
    offset = 7
    len = [@board.played_pegs.last.to_s.length, @board.checked_pegs.last.to_s.length].max
    header = "=" * (len+offset)
    header += "\n"
    print header
    print_pegs# @board.played_pegs, @board.checked_pegs
    print header
  end
end


b = Board.new 4
faze = Interfaze.new b

4.times do |i|
  puts "Secret Code: #{b.secret_code}"
  played_pegs = faze.ask_for_color 4
  pegs = b.add_played_pegs(played_pegs)  
  faze.print_board
  if b.end_game?
    faze.end_banner
    break
  end
end
