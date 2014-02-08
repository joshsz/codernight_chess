require_relative '../spec_helper'
describe ChessBoard do
  let(:simple_board) do
    ChessBoard.build File.read('samples/simple_board.txt')
  end

  it "allows setting squares by coordinate" do
    b = ChessBoard.new
    b.set(0, 0, Rook.new(:black))
    expect(b.at(0,0).piece).to eq(Rook.new(:black))
  end

  it "allows setting squares by notation" do
    b = ChessBoard.new
    b.set('a2', Rook.new(:white))
    expect(b.at('a2').piece).to eq(Rook.new(:white))
  end

  describe "setup" do
    it "should initialize with a 64-space board" do
      b = ChessBoard.new
      expect(b.board.flatten.length).to eq(64)
    end

    it "takes a string as input to initialize the board state" do
      b = simple_board
      expect(b.at(0,0).piece).to eq(Rook.new(:black))
      expect(b.at(1,1).piece).to eq(Pawn.new(:black))
      expect(b.at(3,7).piece).to eq(Queen.new(:white))
    end
  end

  describe "lookup" do
    it "looks up squares by x and y coordinate" do
      expect(simple_board.at(0,0)).to_not be_nil
    end

    it "returns nil for an invalid space" do
      expect(simple_board.at(-1,-1)).to be_nil
    end

    it "looks up squares by algebraic notation" do
      expect(simple_board.at('a1').piece).to eq(Rook.new(:white))
      expect(simple_board.at('h8').piece).to eq(Rook.new(:black))
      expect(simple_board.at('d7').piece).to eq(Pawn.new(:black))
    end

    it "ignores case in algebraic notation" do
      expect(simple_board.at('A1').piece).to eq(Rook.new(:white))
      expect(simple_board.at('H8').piece).to eq(Rook.new(:black))
      expect(simple_board.at('D7').piece).to eq(Pawn.new(:black))
    end
  end

  describe "#valid_move?" do
    it "takes a from and to position and returns something" do
      expect(simple_board.valid_move?("a2", "a3")).to_not be_nil
    end

    it "is invalid when the from piece is empty" do
      expect(simple_board.valid_move?("b3", "a3")).to be_false
    end

    it "is valid for moving a pawn forward one" do
      expect(simple_board.valid_move?("b2", "b3")).to be_true
    end
  end

end

