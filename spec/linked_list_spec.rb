require 'spec_helper'
require_relative "../linked_list"

# rspec spec/linked_list_spec.rb --format documentation

RSpec.describe "Linked List" do
  it "Creating a linked list" do
    ll = LinkedList.new
    expect(ll.class).to eq LinkedList
  end
  context "Appends" do
    it "One value" do
      ll = LinkedList.new
      ll.append "a"
      expect(ll.head.value).to eq "a"
    end
    it "Two values" do
      ll = LinkedList.new
      ll.append "a"
      ll.append "b"
      expect(ll.head.next_node.value).to eq "b"
    end
  end
  context "Prepends" do
    it "One value" do
      ll = LinkedList.new
      ll.prepend "a"
      expect(ll.head.value).to eq "a"
    end
    it "Two values" do
      ll = LinkedList.new
      ll.prepend "a"
      ll.prepend "b"
      expect(ll.head.value).to eq "b"
    end
    context "Size" do
      it "LinkedList empty" do
        ll= LinkedList.new
        expect(ll.size).to eq 0
      end
      it "LinkedList one item" do
        ll = LinkedList.new
        ll.append "a"
        expect(ll.size).to eq 1
      end
      it "LinkedList two items" do
        ll = LinkedList.new
        ll.append "a"
        ll.append "b"
        expect(ll.size).to eq 2
      end
      it "LinkedList append and prepended nodes" do
        ll = LinkedList.new
        ll.append "a"
        ll.prepend "b"
        ll.append "c"
        expect(ll.size).to eq 3
      end
    end
    context "Tail" do
      it "LinkedList empty" do
        ll = LinkedList.new
        expect(ll.tail).to be nil
      end
      it "LinkedList one element" do
        ll = LinkedList.new
        ll.append "a"
        expect(ll.tail.value).to eq "a"
      end
      it "LinkedList two elements" do
        ll = LinkedList.new
        ll.append "a"
        ll.append "b"
        expect(ll.tail.value).to eq "b"
      end
      it "Linked List appended and prepended nodes" do
        ll = LinkedList.new
        ll.append "a"
        ll.prepend "b"
        ll.append "c"
        expect(ll.tail.value).to eq "c"
      end      
    end
    context "At" do
      it "LinkedList empty" do
        ll = LinkedList.new
        expect(ll.at(10)).to be nil
      end
      it "LinkedList one element" do
        ll = LinkedList.new
        ll.append "a"
        expect(ll.at(1).value).to eq "a"
      end
      it "LinkedList one element index out of range" do
        ll = LinkedList.new
        ll.append "a"
        expect(ll.at(10)).to be nil
      end
      it "LinkedList two elements" do
        ll = LinkedList.new
        ll.append "a"
        ll.append "b"
        expect(ll.at(2).value).to eq "b"
      end
      it "LinkedList two elements out of range" do
        ll = LinkedList.new
        ll.append "a"
        ll.append "b"
        expect(ll.at(10)).to be nil
      end
      it "Linked List appended and prepended nodes" do
        ll = LinkedList.new
        ll.append "a"
        ll.prepend "b"
        ll.append "c"
        expect(ll.at(3).value).to eq "c"
      end
      it "Linked List appended and prepended nodes out of range" do
        ll = LinkedList.new
        ll.append "a"
        ll.prepend "b"
        ll.append "c"
        expect(ll.at(10)).to be nil
      end      
    end
    context "Pop" do
      it "Linked List empty" do
        ll = LinkedList.new
        expect(ll.pop).to be nil
      end
      it "Linked List one node" do
        ll = LinkedList.new
        ll.append "a"
        expect(ll.pop.value).to eq "a"
      end
      it "Linked List more nodes" do
        ll = LinkedList.new
        ll.append "a"
        ll.prepend "b"
        ll.append "c"        
        expect(ll.pop.value).to eq "c"
      end
    end
    context "Contains?" do
      it "LinkedList empty" do
        ll = LinkedList.new
        expect(ll.contains? "b").to be false
      end
      it "LinkedList more nodes" do
        ll = LinkedList.new
        ll.append "a"
        ll.prepend "b"
        ll.append "c"
        expect(ll.contains? "b").to be true
      end
      it "LinkedList more nodes not contains" do
        ll = LinkedList.new
        ll.append "a"
        ll.prepend "b"
        ll.append "c"
        expect(ll.contains? "x").to be false
      end
    end
    context "Find" do
      it "LinkedList empty" do
        ll = LinkedList.new
        expect(ll.find "b").to be nil
      end
      it "LinkedList more nodes" do
        ll = LinkedList.new
        ll.append "a"
        ll.prepend "b"
        ll.append "c"
        expect(ll.find "a").to eq 2
      end
      it "LinkedList more nodes not contains" do
        ll = LinkedList.new
        ll.append "a"
        ll.prepend "b"
        ll.append "c"
        expect(ll.find "x").to be nil
      end
    end    
  end
end
