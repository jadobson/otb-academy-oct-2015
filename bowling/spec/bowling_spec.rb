class BowlingFrame
  attr_accessor :frame

  def initialize(frame)
    @frame = frame
  end

  def score(next_frame)
    frame_score = frame_total

    if spare_or_strike? && next_frame
      if strike?
        frame_score += next_frame.frame_total
      else
        frame_score += next_frame.frame[0]
      end
    else
      frame_score
    end
  end

  def frame_total
    @frame_total ||= frame.inject(:+)
  end

  private

  def strike?
    frame[0] == 10
  end

  def spare_or_strike?
    frame_total == 10
  end
end

class BowlingGame
  def initialize(turns)
    @frames = turns.each_slice(2).to_a
  end

  def score
    (0...frame_count).inject(0) do |game_score, i|
      game_score += current_frame(i).score(next_frame(i))
    end
  end

  private

  def frame_count
    @frames.size
  end

  def current_frame(i)
    BowlingFrame.new(@frames[i])
  end

  def next_frame(i)
    if !last_frame?(i)
      BowlingFrame.new(@frames[i + 1])
    end
  end

  def last_frame?(i)
    i == frame_count - 1
  end
end

RSpec.describe "Bowling" do
  it "returns a total score of 0 for 20 failed turns" do
    game = BowlingGame.new(Array.new(20, 0))
    expect( game.score ).to eq(0)
  end

  it "returns a total score of 20 for 20 turns scoring 1" do
    game = BowlingGame.new(Array.new(20, 1))
    expect( game.score ).to eq(20)
  end

  it "can handle spares" do
    game = BowlingGame.new([5, 5, 5] + Array.new(17, 0))
    expect( game.score ).to eq(20)
  end

  it "can handle strikes" do
     game = BowlingGame.new([10, 0, 5, 3] + Array.new(16, 0))
    expect( game.score ).to eq(26)
  end

  it "can handle both spares and strikes" do
    game = BowlingGame.new([10, 0, 5, 5, 3, 3] + Array.new(14, 0))
    expect( game.score ).to eq(39)
  end

  it "scores a mixed game" do
    game = BowlingGame.new([2,4,5,3,1,6,8,2,0,2,6,4,10,0,3,0,10,0,4,5])
    expect( game.score ).to eq(97)
  end
end
