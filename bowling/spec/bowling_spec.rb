class BowlingFrame 
	def initialize(frame)
		@frame = frame
	end

	def score(next_frame_score = 0, single: false)
		frame_total = @frame.inject(:+)

		if strike?
			frame_total += next_frame_score
		elsif spare?
			frame_total += 10
		else
			frame_total
		end
	end

	private

	def strike?
		@frame.include?(10) 
	end

	def spare?
		!strike? && score == 10
	end
end

class BowlingGame
	def initialize(tries)
		@frames = tries.each_slice(2).to_a
	end

	def score
		total_score = 0

		@frames.each_with_index do |frame, i| 
			current_frame = BowlingFrame.new(frame) 
			next_frame = BowlingFrame.new(@frames[i + 1])
			total_score += current_frame.score(next_frame.score)
		end
		
		total_score
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
   	game = BowlingGame.new([10, 0, 5, 3] + Array.new(16, 0))
  	expect( game.score ).to eq(26) 	
  end

  it "can handle both spares and strikes" do
  	game = BowlingGame.new([10, 0, 5, 5, 3, 3] + Array.new(14, 0))
  	expect( game.score ).to eq(46) 
	end
end
