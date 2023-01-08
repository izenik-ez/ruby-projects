require 'spec_helper'
require_relative "../balanced_binary_search_tree"

# rspec spec/balanced_binary_search_tree_spec.rb
#       --format documentation

RSpec.describe "Balanced binary search tree" do
  context "Node class" do
    it "Creates a Node class" do
      n = Node.new
      expect(n.class).to be Node
    end

    it "Attributes initialized to nil" do
      n = Node.new
      expect(n.value).to be nil
      expect(n.right).to be nil
      expect(n.left).to be nil
    end

    it "Attributes setters" do
      n = Node.new
      n.value = 10
      expect(n.value).to be 10
      n.right = "right"
      expect(n.right).to eq "right"
      n.left = "left"
      expect(n.left).to eq "left"
    end

    it "Comparable module" do
      n1 = Node.new
      n1.value = 10
      expect(n1 > 1).to be true
      expect(n1 < 1).to be false
      expect(n1 == 1).to be false
    end
  end
end
