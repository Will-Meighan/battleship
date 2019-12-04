require 'minitest/autorun'
require 'minitest/pride'
require './lib/board'
require './lib/ship'

class BoardTest < Minitest::Test

  def setup
    @board = Board.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 2)
  end

  def test_it_exists
    assert_instance_of Board, @board
  end

  def test_it_begins_with_no_cells
    assert_equals true, board.cells.empty?
  end

  def test_it_creates_cells
    assert_equals 16, board.cells.size
  end

  def test_it_has_coordinates
    assert_equals true, board.valid_coordinate?("A1")
    assert_equals true, board.valid_coordinate?("D4")
    assert_equals false, board.valid_coordinate?("A5")
    assert_equals false, board.valid_coordinate?("E1")
    assert_equals false, board.valid_coordinate?("A22")
  end

  def test_it_has_valid_ratio_coordinates_to_ship
    assert_equal 2, @cruiser.ship.length
    assert_equal 3, @submarine.ship.length
    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

  def test_it_has_consecutive_coordinates
    refute true, board.valid_placement?(cruiser, ["A1", "A2", "A4"])
    refute true, board.valid_placement?(submarine, ["A1", "C1"])
    refute true, board.valid_placement?(cruiser, ["A3", "A2", "A1"])
    refute true, board.valid_placement?(submarine, ["C1", "B1"])
  end

  def test_it_has_no_diagonal_coordinates
    assert_equal false, board.valid_placement?(cruiser, ["A1", "B2", "C3"])
    assert_equal false, board.valid_placement?(submarine, ["C2", "D3"])
  end

  def test_it_has_valid_placement
    assert_equal true, board.valid_placement?(submarine, ["A1", "A2"])
    assert_equal true, board.valid_placement?(cruiser, ["B1", "C1", "D1"])
  end

  def test_it_places_ship_in_coordinates
    board.place(cruiser, ["A1", "A2", "A3"])
    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal Cell, cell_1.class
    assert_equal Cell, cell_2.class
    assert_equal Cell, cell_3.class
    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
    assert true, cell_3.ship == cell_2.ship
  end

  def test_it_has_no_overlapping_ships
    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal false, board.valid_placement?(submarine, ["A1", "B1"])
  end

  def test_it_renders_board
    board.place(cruiser, ["A1", "A2", "A3"])

    assert_equal String, board.render.class
end