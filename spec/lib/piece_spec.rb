require_relative '../spec_helper'
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
  end

end
