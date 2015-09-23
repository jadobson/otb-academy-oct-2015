class StringCalculator
  def add(string)
    negative_numbers = []
    result = parse_numbers(string).inject(0) do |sum, number|
      negative_numbers << number if number < 0
      sum + number
    end
    raise "Negatives not allowed (#{negative_numbers.join(", ")})" if negative_numbers.size > 0

    result
  end

  private

  def parse_numbers(string)
    if custom_delimiter_match = /^\/\/(.+)\n/m.match(string)
      string = string.sub(custom_delimiter_match[0], '')
      custom_delimiter = custom_delimiter_match[1]
    end

    string.split(delimiter_regex(custom_delimiter)).map(&:to_i).reject { |number| number > 1000 }
  end

  def delimiter_regex(custom_delimiter)
    delimiters = if custom_delimiter
      custom_delimiter.scan(/\[?([^\[\]]+)\]?/).flatten.concat(default_delimiters)
    else
      default_delimiters
    end

    Regexp.union(delimiters.sort_by(&:length).uniq.reverse)
  end

  def default_delimiters
    ["\n", ',']
  end
end

RSpec.describe "String calculator" do
  string_calculator = StringCalculator.new

  describe "add" do
    it "returns 0 when an empty string is passed in" do
      expect(string_calculator.add("")).to eq(0)
    end

    it "takes a single number as a string and returns that number as an int" do
      expect(string_calculator.add("1")).to eq(1)
    end

    it "takes a string of delimited numbers and returns the sum" do
      expect(string_calculator.add("1,2")).to eq(3)
    end

    it "handles negative numbers" do
      expect { string_calculator.add("10, 0, -42") }.to raise_error(/Negatives not allowed/)
      expect { string_calculator.add("10, 0, -42") }.to raise_error("Negatives not allowed (-42)")
    end

    it "handles multiple negative numbers" do
      expect{ string_calculator.add("-10, -90, -80, 8" )}.to raise_error(
      "Negatives not allowed (-10, -90, -80)")
    end

    it "allows new lines to be a delimiter" do
      expect(string_calculator.add("1\n2")).to eq(3)
    end

    it "allows you to configure your own delimiters" do
      expect(string_calculator.add("//;\n1;2")).to eq(3)
    end

    it "ignores numbers that are greater than 1000" do
      expect(string_calculator.add("2,1001")).to eq(2)
    end

    it "allows delimiters of any length" do
      expect(string_calculator.add("//[***]\n1***2***3")).to eq(6)
    end

    it "allows multiple delimiters" do
      expect(string_calculator.add("//[*][%]\n1*2%3")).to eq(6)
    end

    it "allows multiple delimiters of any length" do
      expect(string_calculator.add("//[*%][%%%]\n1*%2%%%3")).to eq(6)
    end

    it "allows repeated delimiters" do
      expect(string_calculator.add("//[*%][%%%][*%][*%*%]\n1*%2*%*%3")).to eq(6)
    end
  end
end
