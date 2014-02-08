class Pawn < Piece
  def movements(s, board)
    normal_movements(s, board) + capture_movements(s, board)
  end

  private

    def dir
      dir = white? ? -1 : 1
    end

    def normal_movements(s,board)
      set = [board.at(s.x, s.y + dir)].compact
      if (white? && s.y == 6) || (black? && s.y == 1)
        set << board.at(s.x, s.y + (dir * 2))
      end
      set
    end

    def capture_movements(s, b)
      diags = [
        b.at(s.x - 1, s.y + dir),
        b.at(s.x + 1, s.y  + dir)
      ].compact
      diags.select{|d| d.has_enemy?(color) }
    end
end
