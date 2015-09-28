class BottleNumber
  def initialize(num)
    @num = num
  end

  def decrement
    return 99 if @num == 0
    @num - 1
  end

  def no_more
    @num == 0 ? "no more" : "#{@num}"
  end

  def bottles_remaining
    if @num == 1
      "no more bottles"
    else
      "#{decrement} #{bottles_or_bottle(@num - 1)}"
    end
  end

  def it_or_one
    @num == 1 ? "it" : "one"
  end

  def action
    if @num == 0
      "Go to the store and buy some more"
    else
      "Take #{it_or_one} down and pass it around"
    end
  end

  def bottles_or_bottle(num = @num)
    num == 1 ? "bottle" : "bottles"
  end
end

class Bottles
  def verse(num)
      "#{no_more(num).capitalize} #{bottles_or_bottle(num)} of beer on the wall, #{no_more(num)} #{bottles_or_bottle(num)} of beer.\n" +
        "#{action(num)}, #{bottles_remaining(num)} of beer on the wall.\n"
  end

  def verses(num, num2)
    result = ""
    num.downto(num2).each do |v|
      result += verse(v) + "\n"
    end
    result
  end

  def sing
    verses(99,0)
  end

  private
  def action(num)
    BottleNumber.new(num).action
  end

  def bottles_or_bottle(num)
    BottleNumber.new(num).bottles_or_bottle
  end

  def it_or_one(num)
    BottleNumber.new(num).it_or_one
  end

  def bottles_remaining(num)
    BottleNumber.new(num).bottles_remaining
  end

  def decrement(num)
    BottleNumber.new(num).decrement
  end

  def no_more(num)
    BottleNumber.new(num).no_more
  end
end
