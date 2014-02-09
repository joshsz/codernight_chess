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

  private

    def add_vector_to_set(set, dx, dy, s, b)
      fx = s.x
      fy = s.y
      nx = dx
      ny = dy
      while (ns = b.at(fx + nx, fy + ny)) && !ns.nil? && (ns.piece.nil? || ns.has_enemy?(color))
        set << ns
        break if ns.has_enemy?(color)
        nx += dx
        ny += dy
      end
    end
end

require_relative './piece/pawn'
require_relative './piece/king'
require_relative './piece/queen'
require_relative './piece/knight'
require_relative './piece/bishop'
require_relative './piece/rook'
