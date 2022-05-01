class Ship
  attr_reader :name, :length

  def initialize(name, length)
    @name = name
    @length = length
    @health = length
  end

  def health
    return @health
  end

  def sunk?
    if @health > 0
      return false
    elsif @health == 0
      return true
    else
      return true
    end
  end

  def hit
    @health = @health - 1
  end
end
