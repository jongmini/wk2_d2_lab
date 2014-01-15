require 'rspec'
require './sorted_array.rb'

shared_examples "yield to all elements in sorted array" do |method|
    specify do 
      expect do |b| 
        sorted_array.send(method, &b) 
      end.to yield_successive_args(2,3,4,7,9) 
    end
end

describe SortedArray do
  let(:source) { [2,3,4,7,9] }
  let(:sorted_array) { SortedArray.new source }

  describe "iterators" do
    describe "that don't update the original array" do 
      describe :each do
        context 'when passed a block' do
          it_should_behave_like "yield to all elements in sorted array", :each
        end

        it 'should return the array' do
          sorted_array.each {|el| el }.should eq source
        end
      end

      describe :map do
        it 'the original array should not be changed' do
          original_array = sorted_array.internal_arr
          # setting original_array to sorted_array.internal_arr 
          expect { sorted_array.map {|el| el } }.to_not change { original_array }
        end

        it_should_behave_like "yield to all elements in sorted array", :map
        it 'creates a new array containing the values returned by the block' do
          # pending "fill this spec in with a meaningful example"
          # insert the test for creation of values returned
          original_array = sorted_array.internal_arr
          # sorted_array.map {|el| el}.should eq source
          sorted_array.map {|el| el}.should eq sorted_array.internal_arr

        end
      end
    end

    describe "that update the original array" do
      describe :map! do
        it 'the original array should be updated' do
          sorted_array.map! {|el| el + 1 }.should_not eq sorted_array.map {|el| el + 1 }
        end

        it_should_behave_like "yield to all elements in sorted array", :map!

        it 'should replace value of each element with the value returned by block' do
          # sorted_array.map! {|el| el +1}
          sorted_array.internal_arr == source.map {|el| el + 1}
        end
      end
    end
  end

  describe :find do
    # it_should_behave_like "yield to all elements in sorted array", :find
    it 'should return the value that meets the condition returned by block' do
       sorted_array.find { |x| x % 3 == 0 } == 3
       sorted_array.find { |x| x % 9 == 0 } == nil
    end

    it "should return nil when no values meet the condition" do
      sorted_array.find { |x| x % 9 == 0 } == nil
    end
  end

  describe :inject do
    # it_should_behave_like "yield to all elements in sorted array", :inject
    it "should return the sum of the array when + is passed as the method" do
      sorted_array.inject{ |ele| 0 + ele } == 25
      # pending "define some examples by looking up http://www.ruby-doc.org/core-2.1.0/Enumerable.html#method-i-inject"
    end

    it "should return the total value when each value is multiplied to each" do
      sorted_array.inject{ |ele| 1 * ele } == 1512
      # pending "define some examples by looking up http://www.ruby-doc.org/core-2.1.0/Enumerable.html#method-i-inject"
    end

  end
end
