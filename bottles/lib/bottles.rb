class Bottles
  def sing
    verses(99, 0)
  end

  def verses(finish, start)
    string = ''
    finish.downto(start).each { |count| string << verse(count) + "\n" }
    string
  end

  def verse(count)
    if count == 0
      "No more bottles of beer on the wall, no more bottles of beer.\nGo to the store and buy some more, 99 bottles of beer on the wall.\n"
    elsif count == 1
      "#{count} bottle of beer on the wall, #{count} bottle of beer.\nTake it down and pass it around, no more bottles of beer on the wall.\n"
    elsif count == 2
      "#{count} bottles of beer on the wall, #{count} bottles of beer.\nTake one down and pass it around, #{count - 1} bottle of beer on the wall.\n"
    else
      "#{count} bottles of beer on the wall, #{count} bottles of beer.\nTake one down and pass it around, #{count - 1} bottles of beer on the wall.\n"
    end
  end
end
