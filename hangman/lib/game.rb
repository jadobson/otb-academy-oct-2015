require_relative 'word'

class Game
  attr_reader :incorrect_guesses

  def play(word)
    @correct_word = ''
    @correct_guesses = {}
    @incorrect_guesses = []
    @error_message = ''
    @word = Word.new(word)
  end

  def guess(input)
    set_error_message(input)
    if @error_message == ''
      if @word.match?(input)
        add_correct_guess(input)
      else
        add_incorrect_guess(input)
      end
    end
  end

  def error_message
    @error_message
  end

  def state
    if @correct_word.length > 1
      @correct_word
    else
      @word.state(@correct_guesses)
    end
  end

  def incorrect_guesses_count
    @incorrect_guesses.size
  end

  def incorrect_guesses_string
    @incorrect_guesses.join(', ')
  end

  def finished?
    won? || lost?
  end

  def won?
    @word.word == @correct_word || @word.complete?(@correct_guesses)
  end

  def lost?
    incorrect_guesses_count == incorrect_guess_limit
  end

  private

  def repeat_guess?(input)
    @incorrect_guesses.include?(input) || @correct_guesses.fetch(input, false)
  end

  def invalid_guess?(input)
    (input.length > 1 && input.length != @word.word.length) || input[/^[a-zA-Z]+$/].nil?
  end

  def add_correct_guess(input)
    if input.size > 1
      @correct_word = input
    else
      @correct_guesses[input] = @word.letter_indexes(input)
    end
  end

  def add_incorrect_guess(input)
    @incorrect_guesses << input
  end

  def incorrect_guess_limit
    11
  end

  def set_error_message(input)
    @error_message = determine_error(input).gsub("#input", input)
  end

  def determine_error(input)
    return "<strong>#input</strong> is not a valid guess. Try again." if invalid_guess?(input)
    return "You've already guessed <strong>#input</strong>!" if repeat_guess?(input)
    ""
  end
end
