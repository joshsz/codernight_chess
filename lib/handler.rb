class Handler
  def self.process(board, moves)
    b = ChessBoard.build(board)
    results = moves.split(/\n/).map do |m|
      f, t = m.split(/ /)
      #puts "Checking from #{f} to #{t}"
      b.valid_move?(f,t) ? "LEGAL" : "ILLEGAL"
    end
    "#{results.join("\n")}\n"
  end
end
