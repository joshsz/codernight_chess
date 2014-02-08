require_relative './spec_helper'
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
