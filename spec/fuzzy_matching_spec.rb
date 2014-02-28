require 'spec_helper'
module YouPlayer
  module FuzzyMatching
    describe FuzzyMatch do 
      before :each do
        @match = FuzzyMatch.new
      end
      describe "levenshtein_difference" do
        it "finds equal strings" do 
          @match.levenshtein_difference("One for the road", "One for the road").should eql 0
        end
        it "finds missing characters" do 
          @match.levenshtein_difference("One for the road","One for the roa").should eql 1
        end
        it "finds added characters" do 
          @match.levenshtein_difference("Do i wanna know","Do ia wanna knowa").should eql 2
        end
        it "finds wrong characters" do 
          @match.levenshtein_difference("The Times They Are a-Changin'","The Tames They Are a-Changin'").should eql 1
          @match.levenshtein_difference("Sinister kid","Sanaster kid").should eql 2
        end
      end
      describe "letters_match" do
        it "finds equal strings" do 
          @match.letters_match("Bye bye", "Bye bye").should eql true
        end
        it "finds missing characters" do 
          @match.letters_match("Another brick in the wall","abqtw").should eql false
        end
        it "finds characters present in same order" do 
          @match.letters_match("No excuses","nex").should eql true
          @match.letters_match("Come as you are", "caya").should eql true
        end
      end
    end
  end
end