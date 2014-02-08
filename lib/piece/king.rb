class King < Piece
  def movements(current_space, board)
    n = (-1..1)
    list = []
    fx = current_space.x
    fy = current_space.y
    n.each{|x| n.each{|y| list << board.at(fx + x, fy + y) }}
    list.compact - [current_space]
  end
end
