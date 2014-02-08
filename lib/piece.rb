class Piece
  def initialize(color)
    @color = color
  end

  attr_reader :color

  def type
    self.class.name.downcase.to_sym
  end

  def black?
    color == :black
  end

  def white?
    !black?
  end

  def ==(other)
    other.respond_to?(:color) &&
      other.respond_to?(:type) &&
      other.color == color &&
      other.type == type
  end

  def equals(other)
    self.== other
  end

  def self.from_code(code)
    return nil if code == '--'
    klass = type_from_code(code[1])
    klass.new(color_from_code(code[0]))
  end

  def self.type_from_code(code)
    case code
    when 'R' then Rook
    when 'N' then Knight
    when 'B' then Bishop
    when 'Q' then Queen
    when 'K' then King
    when 'P' then Pawn
    end
  end

  def self.color_from_code(code)
    case code
    when 'b' then :black
    else :white
    end
  end

  def movements(current_space, board); []; end
end

class Rook < Piece ; end
class Knight < Piece ; end
class Bishop < Piece ; end
class Queen < Piece ; end
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
