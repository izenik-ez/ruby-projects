class Pegs
  @@colors = ["Red", "Yellow", "Blue", "Orange", "Green", "Violet"]
  def self.correct_position
    "W"
  end
  def self.color_included
    "R"
  end
  def self.colors
    #["Red", "Yellow", "Blue", "Orange", "Green", "Violet"]
    @@colors
  end
  def self.colors_include?(color)
    @@colors.include? color
  end
end
    
class Board
  include 'Pegs'
  attr_reader :colors, :secret_code,
              :total, :duplicates,
              :played_pegs,
              :checked_pegs
    
  
  def initialize(size, duplicates: nil)
    @colors = Pegs.colors    
    @size = size
    @duplicates = duplicates
    @secret_code = set_secret_code
    @played_pegs = Array.new(@size, Array.new(@size, nil))
    @checked_pegs = Array.new(@size, Array.new(@size, nil))    
  end

  def add_played_pegs (pegs)
    @played_pegs << pegs
    add_checked_pegs(check_played_pegs @played_pegs.last)    
  end

  def get_played_pegs (i)
    @played_pegs[i]
  end
    
  def add_checked_pegs (pegs)
    @checked_pegs << pegs
    @checked_pegs.last
  end

  def get_checked_pegs(i)
    @checked_pegs[i]
  end

  #def color_include? (color)
  #  @colors.include? color
  #end
  
  private
  
  def check_played_pegs (pegs)
    checked = Array.new[@size]
    pegs.each_with_index do |peg, i|
      if peg == @secret_code[i]
        checked[i] = Pegs.correct_position
      elsif color_include? peg
        checked[i] = Pegs.color_included
      end
    end
    checked
  end  

  def set_secret_code
    secret_color_code = []
    color = ""
    @size.times do |i|
      color = colors[rand(@colors.length)]
      redo if @duplicates && secret_color_code.include?(color)
      secret_color_code << color
    end    
    secret_color_code
  end      
end


class Interfaze
  def ask_for_color(total)
    played_pegs = []
    puts "Allowed colors: #{Pegs.colors}"
    total.times do |i|
      print "##{i+1}> "
      color_guess = gets.chomp.downcase.capitalize
      if Pegs.colors_include? color_guess
        color_guess[i] = guess
      else
        redo
      end
    end
    played_pegs
  end

  def print_pegs (played_pegs, checked_pegs)
    offset = 5
    # Get the longer color name and his length
    max_length = Pegs.colors.max{|color| color.length}.length
    played_pegs.each{|peg| print peg.center(max_length+offset)}
    puts
    checked_pegs do |peg|
      if peg.nil?
        print (' ' * (max_length+offset))
      else
        print peg.center(max_length+offset)
      end
    end
  end

  def print_board(board)
    board.played_pegs.each_with_index do |pegs, i|
      unless pegs.any? nil
        print_pegs(pegs, board.get_checked_pegs(i))
        puts
      end      
    end
  end
  
  def end_banner(played_pegs, checked_pegs)
    offset = 5
    len = [played_pegs.to_s.length, checked_pegs.to_s.length].max
    header = "=" * (len+offset)
    header += "\n"
    print header
    print_pegs played_pegs, checked_pegs
    print header
  end
end
