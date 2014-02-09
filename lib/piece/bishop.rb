class Bishop < Piece
  def movements(s, b)
    set = []
    [[1,1], [1,-1], [-1,1], [-1,-1]].each do |dx, dy|
      add_vector_to_set(set, dx, dy, s, b)
    end
    set
  end
end
