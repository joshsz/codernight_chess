require 'pry'
require_relative '../chess_validator'
def coord_to_algebra(x,y)
  "#{('a'..'h').to_a[x]}#{8 - y}"
end
RSpec::Matchers.define :have_spaces do |board, spaces|
  match do |actual|
    actual.sort == spaces.split(/ /).map{|n| board.at(n) }.sort
  end
  failure_message_for_should do |actual|
    alist = actual.map{|s| coord_to_algebra(s.x, s.y) }
    slist = spaces.split(/ /)
    "expected \e[0;31m#{alist.length == 0 ? "''" : alist.join(' ')}\e[0m to have spaces \e[0;32m#{slist.join(' ')}\e[0m, missing \e[0;33m#{(slist - alist).join(' ')}\e[0m"
  end
end
