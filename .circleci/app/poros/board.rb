class Board
  attr_reader :cells, :size, :numbers

  def initialize(size = 4)
    @size = size
    key = "1A2B3C4D5E6F7G8H9I"
    @numbers = ("1".."#{size}").to_a
    coords = []
    numbers.each do |num|
      index = key.index(num)
      let = key[index + 1]
      numbers.each do |num2|
        coords << let + num2
      end
    end
    @cells = {}
    coords.each do |coord|
      @cells[coord] = Cell.new(coord)
    end
  end

  def valid_coordinate?(coordinate)
    @cells.include?(coordinate)
  end

  def valid_placement?(boat, coordinates)
    right_number?(boat, coordinates) &&
    all_on_board?(coordinates) &&
    all_empty?(coordinates) &&
    consecutive?(coordinates)
  end

  def right_number?(boat, coordinates)
    boat.length == coordinates.count
  end

  def all_on_board?(coordinates)
    coordinates.all? { |coord| valid_coordinate?(coord) }
  end

  def all_empty?(coordinates)
    coordinates.all? { |coord| @cells[coord].empty? }
  end

  def consecutive?(coordinates)
    letters = (coordinates.map { |x| x.split("")[0] }).sort
    numbers = (coordinates.map { |x| x.split("")[1] }).sort

    if letters.uniq.size == 1
      numbers == (numbers[0]..numbers[-1]).to_a
    elsif numbers.uniq.size == 1
      letters == (letters[0]..letters[-1]).to_a
    else
      return false
    end
  end

  def place(boat, coordinates)
      coordinates.each do |coord|
        @cells[coord].place_ship(boat)
      end
  end

  def render(show_ships = false)
    rows = @cells.keys.to_a.map do |x|
      x.split("")[0]
    end
    rows.uniq!
    columns = @cells.keys.to_a.map do |x|
      x.split("")[1]
    end
    columns.uniq!

    row = ""
    rows.each do |x|
      row = row + "#{x} "
      row_cells = []
      columns.each do |y|
        row_cells << x + y
      end
      row_cells.each do |z|
        row = row + @cells[z].render(show_ships) + " "
      end
      row = row + "\n"
    end

    return "  " + columns.join(" ") + " \n" + row
  end
end
