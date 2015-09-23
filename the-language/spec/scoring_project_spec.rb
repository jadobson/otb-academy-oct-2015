# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * A set of three ones is 1000 points
#
# * A set of three numbers (other than ones) is worth 100 times the
#   number. (e.g. three fives is 500 points).
#
# * A one (that is not part of a set of three) is worth 100 points.
#
# * A five (that is not part of a set of three) is worth 50 points.
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.

ONE_SCORE  = 100
FIVE_SCORE = 50

def score(dice)
  return 0 if dice.empty?

  count = {
    "1": 0,
    "2": 0,
    "3": 0,
    "4": 0,
    "5": 0,
    "6": 0,
  }

  dice.each do |num|
    count[:"#{num}"] += 1
  end

  score ||= 0

  # Find triples
  triples = count.select do |key, val|
    key_i = key.to_s.to_i

    val >= 3 unless key_i == 1 || key == 5
  end

  if count[:"1"] >= 3
    score += 1000
    count[:"1"] -= 3
  end

  triples.each do |key, val|
    key_i = key.to_s.to_i

    score += key_i * 100
    count[:"#{key}"] -= 3
  end

  score += ONE_SCORE  * count[:"1"] if count[:"1"] > 0
  score += FIVE_SCORE * count[:"5"] if count[:"5"] > 0

  # score = dice.inject(0) do |sum, num|
  #   sum +=  if num == 5
  #             FIVE_SCORE
  #           elsif num == 1
  #             ONE_SCORE
  #           else
  #             0
  #           end
  # end

  score
end

RSpec.describe "scoring a game of greed", scoring: true do
  it "scores an empty list as 0" do
    expect( score([]) ).to eq( 0 )
  end

  it "scores a single 5 as 50" do
    expect( score([5]) ).to eq( 50 )
  end

  it "scores a single 1 as 100" do
    expect( score([1]) ).to eq( 100 )
  end

  it "scores multiple 1s and 5s as a sum of the individual scores" do
    expect( score([1,5,5,1]) ).to eq( 300 )
  end

  it "scores 2s, 3s, 4s, and 6s as 0" do
    expect( score([2,3,4,6]) ).to eq( 0 )
  end

  it "scores triple 1 as 1000" do
    expect( score([1,1,1]) ).to eq( 1000 )
  end

  it "scores other triples as face value * 100" do
    expect( score([2,2,2]) ).to eq( 200 )
    expect( score([3,3,3]) ).to eq( 300 )
    expect( score([4,4,4]) ).to eq( 400 )
    expect( score([5,5,5]) ).to eq( 500 )
    expect( score([6,6,6]) ).to eq( 600 )
  end

  it "can score mixed throws" do
    expect( score([2,5,2,2,3]) ).to eq( 250 )
    expect( score([5,5,5,5]) ).to eq( 550 )
    expect( score([1,1,1,1]) ).to eq( 1100 )
    expect( score([1,1,1,1,1]) ).to eq( 1200 )
    expect( score([1,1,1,5,1]) ).to eq( 1150 )
  end

end
