class ChessBoard
  attr_accessor :board

  def self.build str
    b = new
  end

  def initialize
    build_board
  end

  def set(x,y,piece)
  end

  def at(x,y)
    @board.flatten.detect{|s| s.is?(x,y) }.piece
  end

  private

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
end
