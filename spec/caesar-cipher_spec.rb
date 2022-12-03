# coding: utf-8
require 'spec_helper'
require_relative "../caesar_cipher"

# rspec spec/caesar-cipher_spec.rb --format documentation


RSpec.describe "Caesar Cipher" do
 
  context "Correct shift" do
    it "When is inside limits for LOWERCASE" do
      expect(encode_char "a",5).to eq "f"
    end

    it "When is at the limits for LOWERCASE" do
      expect(encode_char "z", 5).to eq "e"
    end

    it "When is inside limits for UPCASE" do
      expect(encode_char "A", 5).to eq "F"
    end

  end
  context "Correct encoding" do
    it "with char" do
      expect(caesar_cipher "a", 5).to eq "f"
    end
    it "with string" do
      expect(caesar_cipher "Xab ier",4).to eq "Bef miv"
    end
    context "Correct decoding" do
      it "with string" do
        expect(caesar_cipher "Bef miv",-4).to eq "Xab ier"
      end
    end

  end
end
