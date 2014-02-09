require_relative '../../spec_helper'
describe Knight do
  it "moves out two and over one" do
    b = ChessBoard.new
    s = b.at('d4')
    expect(Knight.new(:white).movements(s,b)).
      to have_spaces(b, 'e6 f5 f3 e2 c2 b3 b5 c6')
  end
  it "can move on top of an enemy (and capture)" do
    b = ChessBoard.new
    s = b.at('d4')
    b.set('e6', Pawn.new(:black))
    expect(Knight.new(:white).movements(s,b)).
      to have_spaces(b, 'e6 f5 f3 e2 c2 b3 b5 c6')
  end
  it "cannot move on top of a friendly piece" do
    b = ChessBoard.new
    s = b.at('d4')
    b.set('e6', Pawn.new(:white))
    expect(Knight.new(:white).movements(s,b)).
      to have_spaces(b, 'f5 f3 e2 c2 b3 b5 c6')
  end
end

