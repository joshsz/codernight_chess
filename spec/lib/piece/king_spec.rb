require_relative '../../spec_helper'
describe King do
  it "moves one space in any direction" do
    b = ChessBoard.new
    s = b.at('d4')
    expect(King.new(:white).movements(s,b)).
      to have_spaces(b, 'c3 c4 c5 d3 d5 e3 e4 e5')
  end

  it "can move on top of an enemy (and capture)" do
    b = ChessBoard.new
    s = b.at('d4')
    b.set('e4', Pawn.new(:black))
    expect(King.new(:white).movements(s,b)).
      to have_spaces(b, 'c3 c4 c5 d3 d5 e3 e4 e5')
  end
  it "cannot move on top of a friendly piece" do
    b = ChessBoard.new
    s = b.at('d4')
    b.set('e4', Pawn.new(:white))
    expect(King.new(:white).movements(s,b)).
      to have_spaces(b, 'c3 c4 c5 d3 d5 e3 e5')
  end

  # it can castle?
end

