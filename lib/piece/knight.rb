class Knight < Piece
  def movements(s,b)
    fx = s.x
    fy = s.y
    set = []
    [
      [2,1], [2,-1],
      [1,2], [-1,2],
      [-2,1], [-2,-1],
      [1,-2], [-1,-2]
    ].each do |dx, dy|
      t = b.at(fx + dx, fy + dy)
      set << t if t && (t.piece.nil? || t.has_enemy?(color))
    end
    set
  end
end
