class Space
  attr_accessor :x, :y, :piece
  def initialize(x,y)
    @x = x
    @y = y
  end

  def is?(ox,oy)
    x == ox && y == oy
  end

  def has_enemy?(color)
    piece && piece.color != color
  end

  def ==(other)
    self.equals(other)
  end
  def equals(other)
    other.respond_to?(:x) &&
      other.respond_to?(:y) &&
      other.x == self.x &&
      other.y == self.y
  end

  def <=>(other)
    dx = x <=> other.x
    if dx == 0
      y <=> other.y
    else
      dx
    end
  end
end
