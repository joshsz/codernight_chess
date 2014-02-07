class ChessBoard
  attr_accessor :board

  def self.build(str)
    b = new
    str.split(/\n/).each_with_index do |row, y|
      row.split(/ /).each_with_index do |space, x|
        b.set(x,y, Piece.from_code(space))
      end
    end
    b
  end

  def initialize
    build_board
  end

  def set(x,y,piece)
    space_at(x,y).piece = piece
  end

  def at(x,y=nil)
    if y.nil?
      space_at(*coords_from_notation(x)).piece
    else
      space_at(x,y).piece
    end
  end

  private

    def coords_from_notation(n)
      col = n[0]
      row = n[1]
      x = ('a'..'h').to_a.index(col)
      y = 8 - row.to_i
      [x,y]
    end

    def space_at(x,y)
      @board.flatten.detect{|s| s.is?(x,y) }
    end

    def build_board
      @board = []
      8.times do |y|
        row = []
        8.times do |x|
          row << Space.new(x,y)
        end
        @board << row
      end
    end
end

class Space
  attr_accessor :x, :y, :piece
  def initialize(x,y)
    @x = x
    @y = y
  end

  def is?(ox,oy)
    x == ox && y == oy
  end
end

class Piece
  def initialize(color, type)
    @color = color
    @type = type
  end

  attr_reader :color, :type

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
    Piece.new(color_from_code(code[0]), type_from_code(code[1]))
  end

  def self.type_from_code(code)
    case code
    when 'R' then :rook
    when 'N' then :knight
    when 'B' then :bishop
    when 'Q' then :queen
    when 'K' then :king
    when 'P' then :pawn
    end
  end

  def self.color_from_code(code)
    case code
    when 'b' then :black
    else :white
    end
  end
end
