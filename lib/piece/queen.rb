class Queen < Piece
  def movements(s, b)
    set = []
    [
      [1,1], [1,-1], [-1,1], [-1,-1], #bishop
      [1,0], [0,-1], [-1,0], [0,1], #rook
    ].each do |dx, dy|
      add_vector_to_set(set, dx, dy, s, b)
    end
    set
  end
end
