class Node
  attr_accessor :value, :next_node
  def initialize (value=nil, next_node=nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_reader :head
  def initialize 
    @head = nil
  end

  def append (value)
    if @head.nil?
      @head = Node.new value
    elsif      
      temp = @head
      until temp.next_node.nil?        
        temp = temp.next_node
      end
      temp.next_node = Node.new value
    end
  end
  # def append(value)
  #   temp = @head
  #   until temp.nil?
  #     temp = temp.next_node
  #   end
  #   temp = Node.new value
  # end
  
  def prepend (value)
    new_node = Node.new value
    new_node.next_node = @head
    @head = new_node    
  end

  def size
    i = 0
    return i if @head.nil?
    temp = @head

    until temp.nil?
      i+= 1
      temp = temp.next_node
    end
    i
  end

  def tail
    return nil if @head.nil?
    temp = @head
    until temp.next_node.nil?
      temp = temp.next_node
    end
    temp
  end

  def at(index)
    return nil if @head.nil?
    return nil if index > size
    temp = @head
    (index-1).times{|i| temp = temp.next_node}
    temp          
  end

  def pop
    return nil if @head.nil?
    temp = @head
    prev = nil
    until temp.nil? do
      prev = temp
      temp = temp.next_node
    end
    prev.next_node = nil
    prev    
  end

  def contains?(value)
    temp = @head
    until temp.nil? #next_node.nil?
      if temp.value == value
        return true
      else
        temp = temp.next_node
      end      
    end    
    return false
  end

  def find(value)
    return nil if @head.nil?
    temp = @head
    i = 1
    until temp.nil?
      if temp.value == value
        return i
      else
        i += 1
        temp = temp.next_node
      end
    end
    return nil      
  end

  def insert_at(value, index)
    return nil if size < index    
    temp = @head
    1.upto(index-1){|i| temp = temp.next_node}
    temp_next_node = temp.next_node
    temp.next_node = Node.new value, temp_next_node
  end

  def remove_at(index)
    return nil if size < index    
    temp = @head
    1.upto(index-1){|i| temp = temp.next_node}
    temp_next_node = temp.next_node.next_node
    temp.next_node = temp_next_node
  end
  
  def to_s
    temp = @head
    st = ""
    until temp.next_node.nil?
      st += "(#{temp.value}) -> "
      temp = temp.next_node
    end
    st += "(#{temp.value}) -> (nil)"
  end
end

=begin
ll = LinkedList.new

ll.append "bat"
ll.append "bi"
ll.append "hiru"
ll.prepend "lau"

puts "Size: #{ll.size}"
puts ll.to_s
puts ll.head
puts "Tail's value #{ll.tail.value}"
puts "At index 2 #{ll.at(2).value}"

ll.pop
puts ll.to_s

ll.append "hiru"
puts ll.to_s
print "Contains bi?: "
puts ll.contains? "hiru"

print "Contains hamar?"
puts ll.contains? "hamar"

print "Find value hiru: "
puts ll.find "hiru"

print "Find value hamar: "
puts ll.find "hamar"

print "Find value lau: "
puts ll.find "lau"

puts ll.to_s
ll.insert_at("bost", 2)
puts ll.to_s

ll.remove_at 2
puts ll.to_s
=end
