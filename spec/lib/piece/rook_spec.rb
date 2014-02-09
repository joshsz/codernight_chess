require_relative '../../spec_helper'
describe Rook do
  it "moves any number of spaces along a straight line" do
    b = ChessBoard.new
    s = b.at('d4')
    expect(Rook.new(:white).movements(s,b)).
      to have_spaces(b, 'a4 b4 c4 e4 f4 g4 h4 d1 d2 d3 d5 d6 d7 d8')
  end
  it "can move on top of an enemy (and capture)" do
    b = ChessBoard.new
    b.set('b5', Pawn.new(:black))
    expect(Rook.new(:white).movements(b.at('d5'), b)).
      to have_spaces(b, 'b5 c5 e5 f5 g5 h5 d1 d2 d3 d4 d6 d7 d8')
  end
  it "cannot move on top of a friendly piece" do
    b = ChessBoard.new
    b.set('b5', Pawn.new(:white))
    expect(Rook.new(:white).movements(b.at('d5'), b)).
      to have_spaces(b, 'c5 e5 f5 g5 h5 d1 d2 d3 d4 d6 d7 d8')
  end
end

