require './chess_board'
describe Piece do
  it "requires color to init" do
    ->{
      Piece.new
    }.should raise_exception

    ->{
      Piece.new(:black)
    }.should_not raise_exception
  end

  it "is white or black" do
    p = Piece.new(:black)
    expect(p.color).to eq(:black)
    expect(p.black?).to be_true
    expect(p.white?).to be_false
  end

  describe "equality" do
    it "is equal if its color and type are equal" do
      p1 = Rook.new(:black)
      p2 = Rook.new(:white)
      p3 = Pawn.new(:black)
      p4 = Rook.new(:black)

      expect(p1).to_not eq(p2)
      expect(p1).to_not eq(p3)
      expect(p1).to     eq(p4)
    end
  end

  describe "coding" do
    it "generates the right piece from a code" do
      expect(Piece.from_code('--')).to be_nil
      expect(Piece.from_code('wN')).to eq(Knight.new(:white))
      expect(Piece.from_code('bK')).to eq(King.new(:black))
    end
  end

  describe "movements" do
    it "sends an empty list for a default Piece" do
      expect(Piece.new(:white).movements).to eq([])
    end

    describe Pawn do
      it "moves forward one space"
      it "moves forward two spaces if it is on its second row"
      it "moves diagonally if there is an enemy to capture"
      it "moves diagonally if an enemy has just passed it" #en passant
    end

    describe King do
      it "moves one space in any direction" do
        expect(King.new(:white).movements).to eq([
          [-1, -1], [-1, 0], [-1, 1],
          [ 0, -1],          [ 0, 1],
          [ 1, -1], [ 1, 0], [ 1, 1]
        ])
      end
    end

    describe Queen do
      it "moves any number of spaces in any single direction"
    end

    describe Bishop do
      it "moves any number of spaces along a diagonal"
    end

    describe Knight do
      it "moves out two and over one"
    end

    describe Rook do
      it "moves any number of spaces along a straight line"
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
  let(:sample_board) do
    ChessBoard.build <<EOT
bR bN bB bQ bK bB bN bR
bP bP bP bP bP bP bP bP
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
-- -- -- -- -- -- -- --
wP wP wP wP wP wP wP wP
wR wN wB wQ wK wB wN wR
EOT
  end

  it "allows setting squares by coordinate" do
    b = ChessBoard.new
    b.set(0, 0, Rook.new(:black))
    expect(b.at(0,0)).to eq(Rook.new(:black))
  end

  describe "setup" do
    it "should initialize with a 64-space board" do
      b = ChessBoard.new
      expect(b.board.flatten.length).to eq(64)
    end

    it "takes a string as input to initialize the board state" do
      b = sample_board
      expect(b.at(0,0)).to eq(Rook.new(:black))
      expect(b.at(1,1)).to eq(Pawn.new(:black))
      expect(b.at(3,7)).to eq(Queen.new(:white))
    end
  end

  describe "lookup" do
    it "looks up squares by x and y coordinate" do
      expect(sample_board.at(0,0)).to_not be_nil
    end

    it "looks up squares by algebraic notation" do
      expect(sample_board.at('a1')).to eq(Rook.new(:white))
      expect(sample_board.at('h8')).to eq(Rook.new(:black))
      expect(sample_board.at('d7')).to eq(Pawn.new(:black))
    end
  end

end
