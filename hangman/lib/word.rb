class Word
  attr_reader :word

  def initialize(word)
    @word = word
  end

  def state(correct_guesses)
    word_state = Array.new(@word.length, '_')

    correct_guesses.each do |letter, indexes|
      indexes.each { |index| word_state[index] = letter }
    end

    word_state.join
  end

  def match?(input_string)
    if input_string.length > 1
      @word == input_string
    else
      letter_indexes(input_string).size > 0
    end
  end

  def complete?(correct_guesses)
    correct_guesses.values.flatten.size == @word.length
  end

  def letter_indexes(letter)
    (0...@word.length).find_all { |i| @word[i] == letter }
  end
end
