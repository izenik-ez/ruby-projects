def fibs (n)
  arr = [0, 1]
  n -= 2
  n.times do |i|
    arr << arr[-2] + arr[-1]
    n -= 1
  end
  arr
end
  
p fibs 15

def fibs_rec (n)
  n <= 2 ? 1 : fibs_rec(n-1) + fibs_rec(n-2)
end
  
p (0..10).map{|x| fibs_rec x}

#https://github.com/JonathanYiv/fibonacci/blob/master/fibonacci.rb

def fibs_rec2(number, solution=[0,1])
  solution << solution[-1] + solution[-2]
  fibs_rec2(number-1, solution) if number > 0
  #solution.pop(2)
  solution
end

puts "JonathanYiv solution"
p fibs_rec2(10)

#https://github.com/Ganthology/ruby_recursion/blob/main/lib/fibonacci.rb
def fibs_rec3(n)
  return [0] if n == 0
  return [0,1] if n == 1

  array = fibs_rec3(n-1)
  array << array[-2] + array[-1]
end

puts "Ganthology solution"
puts fibs_rec3(10)
