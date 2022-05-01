require './spec/poros/poros_spec_helper.rb'

RSpec.describe "Cell" do
  it "exists" do
    board = Board.new(4)
    expect(board).to be_instance_of(Board)
  end

  it "has coordinates" do
    board = Board.new(4)
    expect(board.cells.keys).to eq(["A1","A2","A3","A4","B1","B2","B3","B4","C1","C2","C3","C4","D1","D2","D3","D4"])
  end

  it "validates the coordinate" do
    board = Board.new(4)
    expect(board.valid_coordinate?("A1")).to be(true)
    expect(board.valid_coordinate?("E1")).to be(false)
  end

  it "maps ships to placement" do
    board = Board.new(4)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be(false)
    expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be(false)
    expect(board.valid_placement?(submarine, ["A2", "A3"])).to be(true)
    expect(board.valid_placement?(cruiser, ["A2", "A3", "A4"])).to be(true)
    expect(board.valid_placement?(cruiser, ["A4", "B4", "C4"])).to be(true)
    expect(board.valid_placement?(submarine, ["A2", "B2"])).to be(true)
  end

  it "validates consecutive coordinates" do
    board = Board.new(4)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be(false)
  end

  it "coordinates can’t be diagonal" do
    board = Board.new(4)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be(false)
    expect(board.valid_placement?(submarine, ["C2", "D3"])).to be(false)
  end

  it "places a ship" do
    board = Board.new(4)
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    expect(cell_1.ship).to eq(cruiser)
    expect(cell_2.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cruiser)
    expect(cell_3.ship).to eq(cell_2.ship)
  end

  it "does not allow overlap" do
    board = Board.new(4)
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.place(cruiser, ["A1", "A2", "A3"])

    expect(board.valid_placement?(submarine, ["A1", "B1"])).to be false
    expect(board.valid_placement?(submarine, ["B1", "B2"])).to be true
  end

  it "renders the board" do
    board = Board.new(4)
    cruiser = Ship.new("Cruiser", 3)
    board.place(cruiser, ["A1", "A2", "A3"])

    expect(board.render).to eq("  1 2 3 4 \nA . . . . \nB . . . . \nC . . . . \nD . . . . \n")
    expect(board.render(true)).to eq("  1 2 3 4 \nA S S S . \nB . . . . \nC . . . . \nD . . . . \n")
  end

  it "Chooses a board size" do
    board = Board.new(6)
    expect(board.cells.keys).to eq(["A1","A2","A3","A4","A5","A6","B1","B2","B3","B4","B5","B6","C1","C2","C3","C4","C5","C6","D1","D2","D3","D4","D5","D6","E1","E2","E3","E4","E5","E6","F1","F2","F3","F4","F5","F6"])
  end
end
