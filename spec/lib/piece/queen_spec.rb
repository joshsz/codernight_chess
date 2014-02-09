require_relative '../../spec_helper'
describe Queen do
  it "moves any number of spaces in any single direction" do
    b = ChessBoard.new
    s = b.at('d4')
    expect(Queen.new(:white).movements(s,b)).
      to have_spaces(b, 'a4 b4 c4 e4 f4 g4 h4 d1 d2 d3 d5 d6 d7 d8 e3 f2 g1 c3 b2 a1 c5 b6 a7 e5 f6 g7 h8')
  end
  it "can move on top of an enemy (and capture)" do
    b = ChessBoard.new
    s = b.at('d4')
    b.set('d3', Pawn.new(:black))
    expect(Queen.new(:white).movements(s,b)).
      to have_spaces(b, 'a4 b4 c4 e4 f4 g4 h4 d3 d5 d6 d7 d8 e3 f2 g1 c3 b2 a1 c5 b6 a7 e5 f6 g7 h8')
  end
  it "cannot move on top of a friendly piece" do
    b = ChessBoard.new
    s = b.at('d4')
    b.set('d3', Pawn.new(:white))
    expect(Queen.new(:white).movements(s,b)).
      to have_spaces(b, 'a4 b4 c4 e4 f4 g4 h4 d5 d6 d7 d8 e3 f2 g1 c3 b2 a1 c5 b6 a7 e5 f6 g7 h8')
  end
end

