class Rook < Piece
  def movements(s, b)
    set = []
    [[0,1], [0,-1], [1,0], [-1,0]].each do |dx, dy|
      add_vector_to_set(set, dx, dy, s, b)
    end
    set
  end
end
