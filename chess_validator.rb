require_relative './lib/piece'
require_relative './lib/space'
require_relative './lib/chess_board'
require_relative './lib/handler'

if __FILE__ == $0
  board = File.read(ARGV[0])
  moves = File.read(ARGV[1])
  puts results = Handler.process(board,moves)
end
