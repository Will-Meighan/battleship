require_relative 'cell'

class Board

  attr_accessor :cells

  def initialize
    @cells = {}
  end

  def add_cells
    board_coords = []

    ycoords = ("A".."D").to_a
    xcoords = ("1".."4").to_a

    ycoords.each do |y|
      xcoords.each do |x|
        board_coords << y + x
      end
    end

    board_coords.each do |c|
      @cells[c] = Cell.new(c)
    end
  end

  def valid_coordinate?(coordinate)
    @cells.keys.include?(coordinate)
  end

  def correct_length?(ship, coordinates)
    ship.length == coordinates.length
  end

  def letters_same?(ship, coordinates)
    coordinates.all? do |c|
      c[0] == coordinates[0][0]
    end
  end

  def numbers_same?(ship, coordinates)
    coordinates.all? do |c|
      c[1] == coordinates[1][1]
    end
  end

  def letters_consecutive?(ship, coordinates)
    coord_letter_array = coordinates.map do |c|
      c[0]
    end
    letter_range = coord_letter_array[0]..coord_letter_array[-1]
    letter_array = letter_range.to_a
    coord_letter_array == letter_array
  end

  def numbers_consecutive?(ship, coordinates)
    coord_nums_array = coordinates.map do |c|
      c[1]
    end
    numbers_range = coord_nums_array[0]..coord_nums_array[-1]
    numbers_array = numbers_range.to_a
    coord_nums_array == numbers_array
  end

  def valid_placement?(ship, coordinates)

    return false if !correct_length?(ship, coordinates)

    if letters_same?(ship, coordinates) && numbers_consecutive?(ship, coordinates)
      coordinates.all? do |c|
        valid_coordinate?(c)
      end

    elsif numbers_same?(ship, coordinates) && letters_consecutive?(ship, coordinates)
      coordinates.all? do |c|
        valid_coordinate?(c)
      end

    else
      false
    end
    
  end

end
