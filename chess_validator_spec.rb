require './chess_board'
require 'pry'

RSpec::Matchers.define :have_spaces do |board, spaces|
  match do |actual|
    actual.sort == spaces.split(/ /).map{|n| board.at(n) }.sort
  end
end

describe Piece do
  let(:simple_board) do
    ChessBoard.build File.read('samples/simple_board.txt')
  end
  let(:complex_board) do
    ChessBoard.build File.read('samples/complex_board.txt')
  end

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
    let(:bottom_edge) {Space.new()}
    it "sends an empty list for a default Piece" do
      expect(Piece.new(:white).movements(nil,nil)).to eq([])
    end

    describe Pawn do
      context "white in the middle" do
        it "moves up one space" do
          b = ChessBoard.new
          s = b.at('d4')
          expect(Pawn.new(:white).movements(s,b)).
            to have_spaces(b, 'd5')
        end
      end
      context "white on row 2" do
        it "moves forward one or two spaces" do
          b = ChessBoard.new
          s = b.at('a2')
          expect(Pawn.new(:white).movements(s,b)).
            to have_spaces(b, 'a3 a4')
        end
      end
      context "black on row 2" do
        it "moves down one space" do
          b = ChessBoard.new
          s = b.at('a2')
          expect(Pawn.new(:black).movements(s,b)).
            to have_spaces(b, 'a1')
        end
      end
      context "black on row 7" do
        it "moves forward one or two spaces" do
          b = ChessBoard.new
          s = b.at('a7')
          expect(Pawn.new(:black).movements(s,b)).
            to have_spaces(b, 'a6 a5')
        end
      end
      context "capturing" do
        before(:each) { @b = ChessBoard.new }
        context "white" do
          before(:each) { @b.set('b3', Pawn.new(:white)) }
          it "can capture one enemy" do
            @b.set('a4', Pawn.new(:black))
            expect(Pawn.new(:white).movements(@b.at('b3'), @b)).
              to have_spaces(@b, 'a4 b4')
          end
          it "can capture two enemies" do
            @b.set('a4', Pawn.new(:black))
            @b.set('c4', Pawn.new(:black))
            expect(Pawn.new(:white).movements(@b.at('b3'), @b)).
              to have_spaces(@b, 'a4 b4 c4')
          end
        end
      end
      it "can move on top of an enemy (and capture)"
      it "cannot move on top of a friendly piece"

      # can't actually do en-passant
      # it "moves diagonally if an enemy has just passed it" #en passant
    end

    describe King do
      it "moves one space in any direction" do
        b = ChessBoard.new
        s = b.at('d4')
        expect(King.new(:white).movements(s,b).sort).
          to have_spaces(b, 'c3 c4 c5 d3 d5 e3 e4 e5')
      end

      it "can move on top of an enemy (and capture)"
      it "cannot move on top of a friendly piece"
    end

    describe Queen do
      it "moves any number of spaces in any single direction"
      it "can move on top of an enemy (and capture)"
      it "cannot move on top of a friendly piece"
    end

    describe Bishop do
      it "moves any number of spaces along a diagonal"
      it "can move on top of an enemy (and capture)"
      it "cannot move on top of a friendly piece"
    end

    describe Knight do
      it "moves out two and over one"
      it "can move on top of an enemy (and capture)"
      it "cannot move on top of a friendly piece"
    end

    describe Rook do
      it "moves any number of spaces along a straight line"
      it "can move on top of an enemy (and capture)"
      it "cannot move on top of a friendly piece"
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

describe Handler do
  it "takes an input board and moves" do
    board = File.read('samples/simple_board.txt')
    moves = File.read('samples/simple_moves.txt')
    results = Handler.process(board,moves)
    expect(results).to_not be_nil
  end

  it "processes the simple board correctly" do
    pending
    board = File.read('samples/simple_board.txt')
    moves = File.read('samples/simple_moves.txt')
    expected_results = File.read('samples/simple_results.txt')
    results = Handler.process(board,moves)
    expect(results).to eq(expected_results)
  end
end
