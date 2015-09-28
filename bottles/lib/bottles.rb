class BottleNumber
  def initialize(num)
    @num = num
  end

  def decrement
    return 99 if none?
    @num - 1
  end

  def no_more
    none? ? "no more" : "#{@num}"
  end

  def it_or_one
    last? ? "it" : "one"
  end

  def action
    if none?
      "Go to the store and buy some more"
    else
      "Take #{it_or_one} down and pass it around"
    end
  end

  def bottles_or_bottle
    last? ? "bottle" : "bottles"
  end

  private

  def last?
    @num == 1
  end

  def none?
    @num == 0
  end
end

class Bottles
  def verse(num)
    bottle_number = BottleNumber.new(num)
    next_bottle = BottleNumber.new(bottle_number.decrement)

    "#{bottle_number.no_more.capitalize} #{bottle_number.bottles_or_bottle} of beer on the wall, "\
    "#{bottle_number.no_more} #{bottle_number.bottles_or_bottle} of beer.\n"\
    "#{bottle_number.action}, #{next_bottle.no_more} #{next_bottle.bottles_or_bottle} of beer on the wall.\n"
  end

  def verses(num, num2)
    result = ""
    num.downto(num2).each { |v| result += verse(v) + "\n" }
    result
  end

  def sing
    verses(99,0)
  end
end
