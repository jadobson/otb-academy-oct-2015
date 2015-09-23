RSpec.describe "Bowling" do

  #
  # [0] => 0
  # [1] => 1
  # [1, 1, 1, 1] => 4
  # [5, 5, 1, 1] => 22
  # [10, 0, 5, 5] => 30

  it "returns a total score of 0 for 20 failed tries" do
    expect( score(["0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0"]) )
  end


end
