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

class DiceGreed
  def score(dice)
    dice.group_by{ |dice_value| dice_value }.values.inject(0) do |running_score, dice_value_set|
      running_score + dice_value_score(dice_value_set[0], dice_value_set.size)
    end
  end

  private

  def dice_value_score(dice_value, count)
    by_three = count.divmod(3)
    (by_three[0] * set_value_modifier(dice_value)) + (by_three[1] * single_value_modifier(dice_value))
  end

  def set_value_modifier(dice_value)
    return 1000 if dice_value == 1
    100 * dice_value
  end

  def single_value_modifier(dice_value)
    return 100 if dice_value == 1
    return 50 if dice_value == 5
    0
  end
end

RSpec.describe "scoring a game of greed" do
  dice = DiceGreed.new

  it "scores an empty list as 0" do
    expect( dice.score([]) ).to eq( 0 )
  end

  it "scores a single 5 as 50" do
    expect( dice.score([5]) ).to eq( 50 )
  end

  it "scores a single 1 as 100" do
    expect( dice.score([1]) ).to eq( 100 )
  end

  it "scores multiple 1s and 5s as a sum of the individual scores" do
    expect( dice.score([1,5,5,1]) ).to eq( 300 )
  end

  it "scores 2s, 3s, 4s, and 6s as 0" do
    expect( dice.score([2,3,4,6]) ).to eq( 0 )
  end

  it "scores triple 1 as 1000" do
    expect( dice.score([1,1,1]) ).to eq( 1000 )
  end

  it "scores other triples as face value * 100" do
    expect( dice.score([2,2,2]) ).to eq( 200 )
    expect( dice.score([3,3,3]) ).to eq( 300 )
    expect( dice.score([4,4,4]) ).to eq( 400 )
    expect( dice.score([5,5,5]) ).to eq( 500 )
    expect( dice.score([6,6,6]) ).to eq( 600 )
  end

  it "can score mixed throws" do
    expect( dice.score([2,5,2,2,3]) ).to eq( 250 )
    expect( dice.score([5,5,5,5]) ).to eq( 550 )
    expect( dice.score([1,1,1,1]) ).to eq( 1100 )
    expect( dice.score([1,1,1,1,1]) ).to eq( 1200 )
    expect( dice.score([1,1,1,5,1]) ).to eq( 1150 )
  end
end
