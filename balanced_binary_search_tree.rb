# coding: utf-8
class Node
  include Comparable
  attr_accessor :value, :left, :right

  def initialize
    @value = nil
    @left = nil
    @right = nil
  end

  def <=> (value)
    @value <=> value
  end
end

class Tree
  attr_reader :root, :array

  def initialize(array)
    @array = array.uniq.sort
    @root = nil
    build_tree @array
  end

  def build_tree(array)
    return nil if array.empty?
    mid = (array.size - 1)/ 2
    
    node = Node.new
    node.value = (array[mid])
    @root = node if @root.nil?
    
    node.left = build_tree(array[0...mid])
    node.right = build_tree(array[(mid+1)..-1])

    node
  end

  def insert(value)
    node = Node.new
    node.value = value
    @root = node if @root.nil?

    prev = nil
    temp = @root

    while(temp)
      prev = temp
      if temp.value > value
        temp = temp.left
      elsif temp.value < value        
        temp = temp.right
      end
    end

    if prev.value > value
      prev.left = node
    else
      prev.right = node
    end
  end


  
  def remove (value)
    node = find value
    
    return nil if node.nil?

    # 1. If the node has no children
    if is_leaf node
      parent = get_parent value
      parent.right = nil if parent.right && parent.right.value == value
      parent.left = nil if parent.left && parent.left.value == value
    # 2.If the node has one child, return the non-null subtree    
    elsif node.right.nil?
      node.value = node.left.value
      node.left = nil
    elsif node.left.nil?
      node.value = node.right.value
      node.right = nil
    else
      min = get_min(node.right)
      puts "Min is: #{min.value}"
      #node.value = min.value
      temp = min.value
      #node.value = min.value
      remove min.value      
      node.value = temp
    end
  end
# FROM https://medium.com/analytics-vidhya/implement-a-binary-search-tree-in-ruby-c3fa9192410b
  def remove2(value, node = @root)
    return nil if node.nil?

    if node.value > value
      node.left = remove2 value, node.left
    elsif node.value < value
      node.right = remove2 value, node.right
    else
      if node.left != nil && node.right != nil
        temp = node
        min_of_right_subtree = find node.right.value
        node.value = min_of_right_subtree.value
        node.right = remove2 min_of_right_subtree.value,
                            node.right
      elsif node.left != nil
        node = node.left
      elsif node.right != nil
        node = node.right
      else
        node = nil
      end
    end
    return node
  end


  def find(value)
    return nil if @root.nil?
    temp = @root
    while(temp)
      return temp if temp.value == value
      if temp.value > value
        temp = temp.left
      else
        temp = temp.right
      end      
    end
  end

  def find_rec(value, root=@root)
    return nil if root.nil?
    return root if root.value == value

    if root.value > value
      find_rec value, root.left
    else
      find_rec value, root.right
    end
  end

  def is_leaf(node)
    node.right.nil? && node.left.nil?
  end

  def level_order
    queue = [@root]
    result = []
    until queue.empty?
      node = queue.shift
      block_given? ? yield(node) : result << node.value
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
    result unless block_given?
  end

  def preorder(node=@root, output = [], &block)
    # Root Left Right
    return if node.nil?

    block_given? ? yield(node) : output << node.value
    preorder node.left, output, &block
    preorder node.right, output, &block
  end
  
  def inorder(node=@root, output = [], &block)
    # Left Root Right
    return if node.nil?

    inorder(node.left, output, &block)
    block_given? ? yield(node) : output << node.value
    inorder(node.right, output, &block)
  end

  def postorder(node=@root, output= [], &block)
    # Left Right Root
    return if node.nil?

    postorder(node.left, output, &block)
    postorder(node.right, output, &block)
    block_given? ? yield(node) : output << node.value
  end

  def height(node=@root, count = -1)
    return count if node.nil?

    count += 1
    [height(node.left, count), height(node.right,count)].max
  end

  def depth(node)
    return nil if node.nil?

    curr_node = @root
    count = 0
    until curr_node.data == node.data
      count += 1
      curr_node = curr_node.left if node.data < curr_node.data
      curr_node = curr_node.right if node.data > curr_node.data
    end
    count
  end

  def balanced?
    left = height(@root.left, 0)
    right = height(@root.right, 0)
    (left - right).between?(-1, 1)
  end

  def rebalance!
    values = in_order
    @root = build_tree values
  end
  
  def get_parent(value, root=@root, parent=nil)
    return nil if root.nil?
    return parent if root.value == value
    if root.value > value
      get_parent value, root.left, root
    else
      get_parent value, root.right, root
    end
  end

  
  def get_min(node, parent=nil)
    if node.nil?
      return nil
    elsif node.left.nil?
      return node
    end
    get_min(node.left)
  end
  
  def pretty_print(node = @root, prefix='',is_left=true)
    pretty_print(node.right, "#{prefix}#{is_left ? '|  ' : '   '}" ,false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}" ,true) if node.left
end
  
end



tree = Tree.new [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree.pretty_print

tree.insert 10


#node = tree.get_parent 3
# puts "Parent Node is #{node} and value is #{node.value if node}"
#tree.remove 4

#node = tree.get_min tree.find 4
#puts "Min Node is #{node} and value is #{node.value if node}"
# node = tree.find 3
# puts "Node is #{node} and value is #{node.value if node}"
# node = tree.find_rec 3
# puts "Recursive Node is #{node} and value is #{node.value}"

#tree.pretty_print
puts tree.level_order

tree.level_order{|n| print "#{n.value} "}

puts tree.preorder
tree.preorder{|n| print "--> #{n.value} "}

