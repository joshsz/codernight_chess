class Handler
  def self.process(board, moves)
    b = ChessBoard.build(board)
    results = moves.split(/\n/).map do |m|
      f, t = m.split(/ /)
      puts "checking from #{f} to #{t}"
      b.valid_move?(f,t) ? "LEGAL" : "ILLEGAL"
    end
    results.join("\n")
  end
end

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

  def valid_move?(f, t)
    from = at(f)
    to   = at(t)

    return false unless from.piece
    from.piece.movements(from, self).include? to
  end

  def set(x,y,piece)
    at(x,y).piece = piece
  end

  def at(x,y=nil)
    if y.nil?
      space_at(*coords_from_notation(x))
    else
      space_at(x,y)
    end
  end

  private

    def coords_from_notation(n)
      col = n[0]
      row = n[1]
      x = ('a'..'h').to_a.index(col.downcase)
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
  def movements(current_space, board)
    [board.at(current_space.x, current_space.y - 1)].compact
  end
end
