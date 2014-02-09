require_relative '../spec_helper'

describe Handler do
  it "takes an input board and moves" do
    board = File.read('samples/simple_board.txt')
    moves = File.read('samples/simple_moves.txt')
    results = Handler.process(board,moves)
    expect(results).to_not be_nil
  end

  it "processes the simple board correctly" do
    board = File.read('samples/simple_board.txt')
    moves = File.read('samples/simple_moves.txt')
    expected_results = File.read('samples/simple_results.txt')
    results = Handler.process(board,moves)
    expect(results).to eq(expected_results)
  end
end

