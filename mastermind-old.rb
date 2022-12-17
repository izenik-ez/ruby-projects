def colors ()
  ["Red", "Yellow", "Blue", "Orange", "Green", "Violet"]
end

def ask_for_color(total)
  color_guess = []
  puts "Allowed colors: #{colors}"
  total.times do |i|
    print "##{i+1}> "
    guess = gets.chomp.downcase.capitalize
    if colors.include? guess
      color_guess[i] = guess
    else
      redo
    end
  end
  color_guess
end

def get_secret_code (total, colors, duplicates: nil)
  color_code = []
  total.times do |n|
    color = colors[rand(colors.length)]
    if duplicates && color_code.include?(color)
      redo
    else
      color_code << color
    end
  end
  color_code
end

def check_user_guess(guess, secret_color_code)
  puts "Secret Color Code: #{secret_color_code}"
  output = Array.new(guess.length, nil)
  guess.each_with_index do |g, i|
    if g == secret_color_code[i]
      output[i] = "O"
    elsif secret_color_code.include? g
      output[i] = "!"
    end
  end
  output
end

game = {secret_color_code: get_secret_code(4, colors),
        board: Array.new(12, Array.new(4)),
        board_output: Array.new(12, Array.new(4))}

def print_round(round, check)
  max_length = colors.max{|s| s.length}.length
  round.each{|r| print r.center(max_length+5)}
  puts
  check.each do |c|
    if c.nil?
      print(' ' * (max_length+5))
    else
      print c.center(max_length+5)
    end
  end
end


def print_board (game_hash)
  game_hash[:board].each_with_index do |round, i|
    unless round.any? nil      
      print_round round, game_hash[:board_output][i]      
      puts
    end
  end
end

def game_end?(user_guess, secret_color_code)
  user_guess == secret_color_code
end

def end_banner(last_round, last_output)
  len = [last_round.to_s.length, last_output.to_s.length].max
  (len+5).times{|l| print "="}
  puts
  print_round last_round, last_output
  puts
  (len+5).times{|l| print "="}
end

12.times do |i|  
  user_guess = ask_for_color 4 
  game[:board][i] = user_guess
  game[:board_output][i] = check_user_guess(user_guess, game[:secret_color_code])
  if game[:board][i] == game[:secret_color_code]
    #puts "====================="
    #puts "You guess the color!"
    #puts "====================="
    #print_round game[:board][i], game[:board_output][i]
    end_banner game[:board][i], game[:board_output][i]
    puts
    break
  end
    print_board game
end
  
