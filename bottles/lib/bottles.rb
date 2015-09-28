class BottleNumber
  def self.factory(num)
    begin
      factory_class(num).new(num)
    rescue NameError
      BottleNumber.new(num)
    end
  end

  def self.factory_class(num)
    descendants = ObjectSpace.each_object(Class).find_all { |c| c < self }.sort_by { |c| c.name }
    descendants.find { |c| c.handles?(num) }
  end

  def self.handles?(num)
    true
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
    @num
  end

  def pluralize
    "bottles"
  end

  def next
    @next_bottle_number ||= BottleNumber.factory(decrement)
  end
end

class BottleNumber0 < BottleNumber
  def self.handles?(num)
    num == 0
  end

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
  def self.handles?(num)
    num == 1
  end

  def action
    "Take it down and pass it around"
  end

  def pluralize
    "bottle"
  end
end

class BottleNumber6 < BottleNumber
  def self.handles?(num)
    num % 6 == 0
  end

  def action
    "Take one bottle down and pass it around"
  end

  def remaining
    @num / 6
  end

  def pluralize
    remaining > 1 ? "six packs" : "six pack"
  end
end

class Bottles
  def verse(num)
    bottle_number = BottleNumber.factory(num)

    "#{bottle_number.remaining.to_s.capitalize} #{bottle_number.pluralize} of beer on the wall, "\
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
