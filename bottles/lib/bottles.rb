class Bottles
  def verse(num)
    string = "#{how_many_beers_on_the_wall(num).capitalize}, #{bottle_count(num)} of beer.\n"
    string << action(num)
    string << " #{how_many_beers_on_the_wall(next_count(num))}.\n"
  end

  def verses(num, num2)
    num.downto(num2).collect { |v| self.verse(v) }.join("\n") + "\n"
  end

  def sing
    verses(99,0)
  end

  private

  def action(num)
    if num > 0
      "Take #{bottle_descripter(num)} down and pass it around,"
    else
      "Go to the store and buy some more,"
    end
  end

  def how_many_beers_on_the_wall(num)
    "#{bottle_count(num)} of beer on the wall"
  end

  def bottle_descripter(num)
    num == 1 ? "it" : "one"
  end

  def bottle_count(count)
    { 0 => "no more bottles", 1 => "1 bottle" }.fetch(count, "#{count} bottles")
  end

  def next_count(count)
    count == 0 ? 99 : count - 1
  end
end
