require 'pry'
require_relative '../chess_validator'
RSpec::Matchers.define :have_spaces do |board, spaces|
  match do |actual|
    actual.sort == spaces.split(/ /).map{|n| board.at(n) }.sort
  end
end
