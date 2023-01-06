#https://github.com/Ganthology/ruby_recursion/blob/main/lib/merge_sort.rb
def merge_sort(array)
  return array if array.length < 2

  middle = array.length / 2
  left = merge_sort(array[0...middle])
  right = merge_sort(array[middle...array.length])

  sorted = []

  until left.empty? || right.empty?
    left.first <= right.first ? sorted << left.shift : sorted << right.shift
  end

  sorted + left + right
end

p merge_sort([3,4,2,1,5,0,10,9,7,8,6])


#https://github.com/mittalrohit0598/merge_sort/blob/main/merge_sort.rb
def merge_sort2(array)
  if array.size < 2
    array
  else
    left = merge_sort(array[0...array.size / 2])
    right = merge_sort(array[array.size / 2...array.size])
    merge2(left, right)
  end
end

def merge(left, right, array = [])
  (left.size + right.size).times do
    if left.empty?
      array << right.shift
    elsif right.empty?
      array << left.shift
    else
      comparison = left <=> right
      if comparison == -1
        array << left.shift
      elsif comparison == 1
        array << right.shift
      else
        array << left.shift
      end
    end
  end
  array
end

def merge2(left,right)
  array = Array.new(left.size+right.size)
  array.map do |item|
    if left.empty?
      right.shift
    elsif right.empty?
      left.shift
    else
      case left <=> right
      when -1
        left.shift
      when 0
        left.shift
      when 1
        right.shift
      end
    end
  end  
end



arr = []
rand(200).times do
  arr << rand(200)
end

p merge_sort2(arr)
