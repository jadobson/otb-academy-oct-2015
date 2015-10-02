class Input
  def initialize(string, valid_length)
    @string = string
    @valid_length = valid_length
  end

  def validate(previous_guesses)
    if invalid?
      "<strong>#{@string}</strong> is not a valid guess. Try again."
    elsif repeat?(previous_guesses)
      "You've already guessed <strong>#{@string}</strong>! Try again."
    else
      ''
    end
  end

  private

  def repeat?(previous_guesses)
    previous_guesses.include?(@string)
  end

  def invalid?
    invalid_length? || invalid_format?
  end

  def invalid_length?
    @string.length > 1 && @string.length != @valid_length
  end

  def invalid_format?
    @string[/^[a-zA-Z]+$/].nil?
  end
end
