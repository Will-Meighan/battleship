require './lib/player'
require './lib/ship'
require 'minitest/autorun'
require 'minitest/pride'

class PlayerTest < Minitest::Test

  def setup
    @player = Player.new
    @cruiser = Ship.new("Cruiser", 3)
    @submarine = Ship.new("Submarine", 3)
  end

  def test_it_exists
    assert_instance_of Player, @player
  end

  def test_it_has_attributes
    assert_equal [], @player.ships
  end

  def test_it_can_add_ships
    @player.add_ships(@cruiser)
    @player.add_ships(@submarine)

    assert_equal [@cruiser, @submarine], @player.ships
  end

end