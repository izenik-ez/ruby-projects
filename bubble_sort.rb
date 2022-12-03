def bubble_sort (array)

#  temp = 0
  loop do
    swapped = false
    array.each_with_index do |item, index|
      if array[index+1] && item > array[index+1]
        #temp = array[index+1]
        #array[index+1] = item
        #array[index] = temp
        array[index], array[index+1] = array[index+1], array[index]                                             
        swapped = true
      end
    end
    break if swapped == false
  end
  array
end

#puts bubble_sort [1,3,2,5,4]                  
p bubble_sort([4,3,78,2,0,2])
