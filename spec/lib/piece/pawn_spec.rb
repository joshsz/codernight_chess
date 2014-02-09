require_relative '../../spec_helper'
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
  it "cannot move on top of a friendly piece" do
      b = ChessBoard.new
      s = b.at('a7')
      b.set('b6', Pawn.new(:black))
      expect(Pawn.new(:black).movements(s,b)).
        to have_spaces(b, 'a6 a5')
  end

  # can't actually do en-passant
  # it "moves diagonally if an enemy has just passed it" #en passant
end

