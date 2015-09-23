class BowlingGame
	def initialize(tries)
		@frames = tries.each_slice(2).to_a
	end

	def score
		total_score = 0

		@frames.each_with_index do |frame, i| 
			frame_total = calculate_frame_total(frame)
			if frame_total == 10 
				if frame.include?(10) 
					frame_total += calculate_frame_total(@frames[i + 1])
				else
					frame_total += 10
				end
			end

			total_score += frame_total
		end
		
		total_score
	end

	private

	def calculate_frame_total(frame)
		frame.inject(:+)
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
