require './spec/poros/poros_spec_helper.rb'

RSpec.describe "Cell" do
  it "exists" do
    cell = Cell.new("B4")
    expect(cell).to be_instance_of(Cell)
  end

  it "Checks Location of Argunment" do
    cell = Cell.new("B4")

    expect(cell.coordinate).to eq("B4")
  end

  it "Check to see if ship is on that cell" do
    cell = Cell.new("B4")

    expect(cell.ship).to be nil
  end

  it 'Check Cell Ocupancy' do
    cell = Cell.new("B4")
    expect(cell.empty?).to eq(true)
  end

  it 'Cruiser can be placed on a cell' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    expect(cell.ship).to eq(cruiser)
    expect(cell.empty?).to be(false)
  end

  it 'Cell by defult is not fired upon' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    expect(cell.fired_upon?).to be(false)
  end

  it 'cell can be fired_upon and can damage a ship' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    cell.fire_upon
    expect(cell.ship.health).to eq(2)
    expect(cell.fired_upon?).to be(true)
  end

  it 'cell can only be fired upon once' do
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    cell.fire_upon
    cell.fire_upon
    expect(cell.ship.health).to eq(2)
    expect(cell.fired_upon?).to be(true)
  end

  it 'exists' do
    cell_1 = Cell.new("B4")

    expect(cell_1).to be_instance_of(Cell)
  end

  it 'Renders as empty or miss' do
    cell_1 = Cell.new("B4")
    expect(cell_1.empty?).to be(true)
    expect(cell_1.fired_upon?).to be(false)
    expect(cell_1.render).to eq(".")
    cell_1.fire_upon
    expect(cell_1.render).to eq("M")
  end

  it 'ships can be hidden or revealed' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)

    expect(cell_2.render). to eq(".")
    expect(cell_2.render(true)).to eq("S")
  end

  it 'renders a hit' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon
    expect(cell_2.render).to eq("H")
  end

  it 'sinks a ship' do
    cell_2 = Cell.new("C3")
    cruiser = Ship.new("Cruiser", 3)
    cell_2.place_ship(cruiser)
    cell_2.fire_upon

    expect(cruiser.sunk?).to be false

    cruiser.hit
    cruiser.hit

    expect(cruiser.sunk?).to be true
    expect(cell_2.render).to eq("X")
  end
end
