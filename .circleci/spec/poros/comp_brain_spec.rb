require './spec/poros/poros_spec_helper.rb'

RSpec.describe CompBrain do
  it 'exists' do
  brain = CompBrain.new
  expect(brain).to be_instance_of CompBrain
  end

  it 'collects adjacent coordinates from a hit' do
    brain = CompBrain.new
    user_board = Board.new(6)
    ship_1 = Ship.new("cruiser", 3)
    ship_2 = Ship.new("frigate", 4)
    user_board.place(ship_1, ["B2", "B3", "B4"])
    user_board.place(ship_2, ["C6", "D6", "E6", "F6"])
    user_board.cells["B3"].fire_upon
    expect(brain.adj_coords(user_board)).to eq ["A3", "C3", "B2", "B4"]
    user_board.cells["F6"].fire_upon
    expect(brain.adj_coords(user_board)).to eq ["A3", "C3", "B2", "B4", "E6", "G6", "F5", "F7"]
  end

  it 'gives only valid adjacent coordinates' do
    brain = CompBrain.new
    user_board = Board.new(6)
    ship_1 = Ship.new("cruiser", 3)
    ship_2 = Ship.new("frigate", 4)
    user_board.place(ship_1, ["B2", "B3", "B4"])
    user_board.place(ship_2, ["C6", "D6", "E6", "F6"])
    user_board.cells["B3"].fire_upon
    user_board.cells["F6"].fire_upon
    expect(brain.hot_coords(user_board)).to eq ["A3", "C3", "B2", "B4", "E6", "F5"]
  end

  it 'excludes cells that are missed, hit or sunk' do
    brain = CompBrain.new
    user_board = Board.new(6)
    ship_1 = Ship.new("cruiser", 2)
    ship_2 = Ship.new("frigate", 4)
    user_board.place(ship_1, ["B2", "B3"])
    user_board.place(ship_2, ["C3", "C4", "C5", "C6"])
    user_board.cells["B3"].fire_upon
    user_board.cells["B2"].fire_upon
    user_board.cells["C3"].fire_upon
    expect(brain.hot_coords(user_board)).to eq ["D3", "C2", "C4"]
  end
end
