class Handler
  def self.process(board, moves)
    b = ChessBoard.build(board)
    results = moves.split(/\n/).map do |m|
      f, t = m.split(/ /)
      b.valid_move?(f,t) ? "LEGAL" : "ILLEGAL"
    end
    results.join("\n")
  end
end
