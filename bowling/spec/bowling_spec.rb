class BowlingFrame 
	def initialize(frame)
		@frame = frame
	end

	def score(next_frame_total = 0)
		total = frame_total

		if strike?
			total += next_frame_total
		elsif spare?
			total += 10
		else
			total
		end
	end

	def frame_total
		@frame_total ||= @frame.inject(:+)
	end

	private

	def strike?
		@frame.include?(10) 
	end

	def spare?
		!strike? && frame_total == 10
	end
end

class BowlingGame
	def initialize(turns)
		@frames = turns.each_slice(2).to_a
	end

	def score
		total_score = 0

		@frames.each_with_index do |frame_turns, i| 
			next_frame_total = last_frame?(i) ? 0 : get_next_frame(i).frame_total
			total_score += get_current_frame(frame_turns).score(next_frame_total)
		end
		
		total_score
	end

	private

	def get_current_frame(frame_turns)
		BowlingFrame.new(frame_turns)
	end

	def get_next_frame(current_frame_index)
		BowlingFrame.new(@frames[current_frame_index + 1])
	end

	def last_frame?(i)
		i == @frames.size - 1
	end
end

RSpec.describe "Bowling" do
  #
  # [5, 5, 1, 1] => 22
  # [10, 0, 5, 5] => 30

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
  	expect( game.score ).to eq(25)
  end

  it "can handle strikes" do
  	#require 'pry'
  	#binding.pry

   	game = BowlingGame.new([10, 0, 5, 3] + Array.new(16, 0))
  	expect( game.score ).to eq(26) 	
  end

  it "can handle both spares and strikes" do
  	game = BowlingGame.new([10, 0, 5, 5, 3, 3] + Array.new(14, 0))
  	expect( game.score ).to eq(46) 
	end

  it "scores a mixed game" do
    game = BowlingGame.new([2,4,5,3,1,6,8,2,0,2,6,4,10,0,3,0,10,0,4,5])
    expect( game.score ).to eq(97)
  end
end
