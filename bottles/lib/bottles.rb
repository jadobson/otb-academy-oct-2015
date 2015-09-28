class BottleNumber
  def self.new(num)
    if num == 0
      object = BottleNumber0.allocate
    elsif num == 1
      object = BottleNumber1.allocate
    else
      object = BottleNumber.allocate
    end

    object.send(:initialize, num)
    object
  end

  def initialize(num)
    @num = num
  end

  def decrement
    @num - 1
  end

  def action
    "Take one down and pass it around"
  end

  def remaining
    "#{@num}"
  end

  def pluralize
    "bottles"
  end

  def next
    @next_bottle_number ||= BottleNumber.new(decrement)
  end
end

class BottleNumber0 < BottleNumber
  def decrement
    99
  end

  def action
    "Go to the store and buy some more"
  end

  def remaining
    "no more"
  end
end

class BottleNumber1 < BottleNumber
  def action
    "Take it down and pass it around"
  end

  def pluralize
    "bottle"
  end
end

class Bottles
  def verse(num)
    bottle_number = BottleNumber.new(num)

    "#{bottle_number.remaining.capitalize} #{bottle_number.pluralize} of beer on the wall, "\
    "#{bottle_number.remaining} #{bottle_number.pluralize} of beer.\n"\
    "#{bottle_number.action}, #{bottle_number.next.remaining} #{bottle_number.next.pluralize} of beer on the wall.\n"
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
