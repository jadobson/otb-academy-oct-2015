require_relative 'input'
require_relative 'word'

class Game
  attr_reader :incorrect_guesses, :error

  def play(word)
    @correct_guesses = {}
    @correct_word = ''
    @error = ''
    @incorrect_guesses = []
    @word = Word.new(word)
  end

  def guess(input_string)
    @error = Input.new(input_string, @word.word.length).validate(previous_guesses)

    unless error?
      if @word.match?(input_string)
        add_correct_guess(input_string)
      else
        add_incorrect_guess(input_string)
      end
    end
  end

  def state
    if correct_word_guessed?
      @correct_word
    else
      @word.state(@correct_guesses)
    end
  end

  def incorrect_guesses?
    incorrect_guess_count > 0
  end

  def incorrect_guess_count
    @incorrect_guesses.size
  end

  def incorrect_guess_string
    @incorrect_guesses.join(', ')
  end

  def finished?
    won? || lost?
  end

  def won?
    @word.word == @correct_word || @word.complete?(@correct_guesses)
  end

  def lost?
    incorrect_guess_count == incorrect_guess_limit
  end

  def error?
    @error.length > 0
  end

  private

  def previous_guesses
    @correct_guesses.keys + @incorrect_guesses
  end

  def correct_word_guessed?
    @correct_word.length > 0
  end

  def add_correct_guess(input_string)
    if input_string.length > 1
      @correct_word = input_string
    else
      @correct_guesses[input_string] = @word.letter_indexes(input_string)
    end
  end

  def add_incorrect_guess(input_string)
    @incorrect_guesses << input_string
  end

  def incorrect_guess_limit
    11
  end
end
