require 'game'

RSpec.describe "hangman game" do
  let(:game) { Game.new }

  it "draws a blank board given a word" do
    game.play('test')
    expect(game.state).to eq('____')
  end

  before do
    game.play('test')
  end

  it "updates the board on correct guesses" do
    game.guess('t')
    expect(game.state).to eq('t__t')
  end

  it "updates the board on repeat correct guesses" do
    game.guess('t')
    game.guess('e')
    expect(game.state).to eq('te_t')
  end

  it "updates the board on incorrect guesses" do
    game.guess('u')
    expect(game.incorrect_guesses_string).to eq('u')
  end

  it "updates the board on repeat incorrect guesses" do
    game.guess('u')
    game.guess('z')
    expect(game.incorrect_guesses_string).to eq('u, z')
  end

  it "updates the board with a mixture of correct and incorrect guesses" do
    game.guess('t')
    game.guess('u')
    game.guess('z')
    game.guess('e')
    expect(game.state).to eq('te_t')
    expect(game.incorrect_guesses_string).to eq('u, z')
  end

  it "can determine when a game is won from a sequence of correct guesses" do
    game.guess('t')
    game.guess('e')
    game.guess('s')
    expect(game.finished?).to eq(true)
    expect(game.won?).to eq(true)
  end

  it "can determine when a game is lost" do
    game.guess('a')
    game.guess('b')
    game.guess('c')
    game.guess('d')
    game.guess('f')
    game.guess('g')
    game.guess('h')
    game.guess('i')
    game.guess('j')
    game.guess('k')
    game.guess('l')
    expect(game.finished?).to eq(true)
    expect(game.lost?).to eq(true)
  end

  it "can determine when a game is won from a correct word guess" do
    game.guess('test')
    expect(game.won?).to eq(true)
  end
end
