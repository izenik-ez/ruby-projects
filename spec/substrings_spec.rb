# coding: utf-8
require 'spec_helper'
require_relative "../substrings"

# rspec spec/substrings_spec.rb --format documentation


RSpec.describe "Substrings" do
 
  context "Find substring" do
    it "One occurrence" do
      hash = count_substrings "below", "low"
      expectation = { string: "low", count: 1 }
      expect(hash).to eq expectation
    end
    it "Two occurrences" do
      hash = count_substrings "belowlow", "low"
      expectation = { string: "low", count: 2 }
      expect(hash).to eq expectation
    end
    it "No occurrences" do
      hash = count_substrings "below", "zz"
      expect(hash).to eq nil
    end
  end
end
