require_relative '../../spec_helper'

describe Bishop do
  it "moves any number of spaces along a diagonal" do
    b = ChessBoard.new
    s = b.at('d4')
    expect(Bishop.new(:white).movements(s,b)).
      to have_spaces(b, 'e3 f2 g1 c3 b2 a1 c5 b6 a7 e5 f6 g7 h8')
  end
  it "can move on top of an enemy (and capture)" do
    b = ChessBoard.new
    b.set('e3', Pawn.new(:black))
    s = b.at('d4')
    expect(Bishop.new(:white).movements(s,b)).
      to have_spaces(b, 'e3 c3 b2 a1 c5 b6 a7 e5 f6 g7 h8')
  end
  it "cannot move on top of a friendly piece" do
    b = ChessBoard.new
    b.set('e3', Pawn.new(:white))
    s = b.at('d4')
    expect(Bishop.new(:white).movements(s,b)).
      to have_spaces(b, 'c3 b2 a1 c5 b6 a7 e5 f6 g7 h8')
  end

  it "returns its list of captures properly" do
    b = ChessBoard.new
    s = b.at('d4')
    b.set('e5', Pawn.new(:black))
    expect(Bishop.new(:white).captures(s,b)).
      to have_spaces(b, 'e5')
  end

end
