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

end

def pretty_print(node = @root, prefix='',is_left=true)
    pretty_print(node.right, "#{prefix}#{is_left ? '|  ' : '   '}" ,false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}" ,true) if node.left
end

tree = Tree.new [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]



pretty_print tree.root
