class King < Piece
  def movements(current_space, board)
    n = (-1..1)
    list = []
    fx = current_space.x
    fy = current_space.y
    n.each{|x| n.each{|y| list << board.at(fx + x, fy + y) }}
    candidates = (list.compact - [current_space]).select{|s| s.piece.nil? || s.has_enemy?(color)}

    candidates.reject{|s| in_check?(current_space, s, board) }
  end

  def in_check?(current_space, s, b)
    next_b = b.clone
    next_b.set(current_space.x, current_space.y, nil)
    next_b.set(s.x, s.y, self)

    enemies = next_b.spaces.select{|p| p.has_enemy?(color) }

    would_check = enemies.detect do |e|
      e.piece.captures(e,next_b).include? s
    end

    !would_check.nil?
  end
end
