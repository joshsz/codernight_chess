require_relative './spec_helper'
describe Space do
  it "must be initialized with x and y coords" do
    ->{
      Space.new
    }.should raise_exception

    ->{
      Space.new(1,2)
    }.should_not raise_exception
  end

  describe "#is?" do
    it "is if its coords match" do
      s = Space.new(1,2)
      expect(s.is?(1,1)).to be_false
      expect(s.is?(4,2)).to be_false
      expect(s.is?(4,4)).to be_false
      expect(s.is?(1,2)).to be_true
    end
  end

  describe "x and y" do
    let(:s) { Space.new(1,2) }
    it "allows access to x" do
      expect(s.x).to eq 1
    end
    it "allows access to y" do
      expect(s.y).to eq 2
    end
  end

  describe "#has_enemy?" do
    before(:each){ @s = Space.new(1,2) }
    it "is false when there is no piece" do
      expect(@s.has_enemy?(:white)).to be_false
    end
    it "is false when there is a friendly piece" do
      @s.piece = Rook.new(:white)
      expect(@s.has_enemy?(:white)).to be_false
    end
    it "is true when there is an enemy piece" do
      @s.piece = Rook.new(:black)
      expect(@s.has_enemy?(:white)).to be_true
    end
  end

  describe "equality" do
    it "is equal if its x and y match" do
      s1 = Space.new(1,2)
      s2 = Space.new(1,1)
      s3 = Space.new(2,2)
      s4 = Space.new(1,2)

      expect(s1).to_not eq(s2)
      expect(s1).to_not eq(s3)
      expect(s1).to     eq(s4)
    end
  end

  describe "#<=>" do # really just need this for testing...
    it "sorts" do
      s1 = Space.new(1,2)
      s2 = Space.new(1,1)
      s3 = Space.new(2,2)
      s4 = Space.new(1,2)

      expect(s1 <=> s2).to eq( 1)
      expect(s1 <=> s3).to eq(-1)
      expect(s1 <=> s4).to eq( 0)
      expect(s3 <=> s1).to eq( 1)
      expect(s3 <=> s2).to eq( 1)
    end
  end
end

