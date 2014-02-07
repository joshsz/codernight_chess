require './chess_board'
describe Piece do
 it "requires color and type to init" do
    ->{
      Piece.new
    }.should raise_exception

    ->{
      Piece.new(:black, :knight)
    }.should_not raise_exception
  end

  it "is white or black" do
    p = Piece.new(:black, :knight)
    expect(p.color).to eq(:black)
    expect(p.black?).to be_true
    expect(p.white?).to be_false
  end

  describe "equality" do
    it "is equal if its color and type are equal" do
      p1 = Piece.new(:black, :rook)
      p2 = Piece.new(:white, :rook)
      p3 = Piece.new(:black, :pawn)
      p4 = Piece.new(:black, :rook)

      expect(p1).to_not eq(p2)
      expect(p1).to_not eq(p3)
      expect(p1).to     eq(p4)
    end
  end
end

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
end

describe ChessBoard do
  it "allows setting squares by coordinate" do
    b = ChessBoard.new
    b.set(0,0,Piece.new(:black,:rook))
    expect(b.at(0,0)).to_equal Piece.new(:black, :rook)
  end
  describe "setup" do
    it "should initialize with a 64-space board" do
      b = ChessBoard.new
      expect(b.board.flatten.length).to eq(64)
    end

    it "takes a string as input to initialize the board state" do
      b = ChessBoard.build <<EOT
bR bN bB bQ bK bB bN bR
bP bP bP bP bP bP bP bP
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
wP wP wP wP wP wP wP wP
wR wN wB wQ wK wB wN wR
EOT
      expect(b.board[0][0]).to_not be_nil
    end
  end

  describe "lookup" do
    it "looks up squares by x and y coordinate"
    it "looks up squares by algebraic notation"
  end

end
