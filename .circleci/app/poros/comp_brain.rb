class CompBrain
  def initialize
  end

  def adj_coords(board)
    number_key = ("0".."#{board.size + 1}").to_a.join
    letter_key = ["Z" "A", "B", "C", "D", "E", "F", "G", "H", "I", "J"][0..(board.size)].join
    hit_cells = board.cells.select do |key, value|
      value.render == "H"
    end
    adjacent_cells = []
    hit_cells.each do |cell|
      letter = cell[0][0]
      number = cell[0][1]
      index = letter_key.index(letter)
      
      above_letter = letter_key[index - 1]
      below_letter = letter_key[index + 1]
      left_number = number_key[number.to_i - 1]
      right_number = number_key[number.to_i + 1]

      adjacent_cells << above_letter + number
      adjacent_cells << below_letter + number
      adjacent_cells << letter + left_number
      adjacent_cells << letter + right_number
    end
    return adjacent_cells
  end

  def hot_coords(board)
    all_adj_coord = adj_coords(board)
    hot_coords = all_adj_coord.reject do |coord|
      !board.valid_coordinate?(coord) ||
      board.cells[coord].render != "."
    end
    return hot_coords
  end
end
