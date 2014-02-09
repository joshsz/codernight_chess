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

  def set(x_or_coord, y_or_piece, piece=nil)
    if y_or_piece.respond_to? :movements
      at(x_or_coord).piece = y_or_piece
    else
      at(x_or_coord,y_or_piece).piece = piece
    end
  end

  def at(x,y=nil)
    if y.nil?
      space_at(*coords_from_notation(x))
    else
      space_at(x,y)
    end
  end

  def spaces
    board.flatten
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
