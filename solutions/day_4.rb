require 'pry'

class ForkLift
  ROLL = '@'

  def initialize(is_test: false)
    @rows = load_input(is_test)
    @reachable_rolls = 0
  end

  def load_input(is_test)
    File.readlines(get_file_path(is_test)).map(&:chomp).map(&:chars)
  end

  def perform
    @rows.each_with_index do |row, ri|
      row.each_with_index do |space, ci|
        next unless space == ROLL

        check_space(ri, ci)
      end
    end
    puts "reachable rolls: #{@reachable_rolls}"
  end

  def check_space(row_index, col_index)
    filled_spots = 0

    build_adjacent_cells(row_index, col_index).each do |cell|
      next if cell[:row] < 0 || cell[:col] < 0
      next if cell[:row] > @rows.length - 1 || cell[:col] > @rows.first.length - 1
      next if @rows[cell[:row]].nil?
      break if filled_spots == 4

      val = @rows[cell[:row]][cell[:col]]

      filled_spots += 1 if val && val == ROLL
    end

    puts "\n -----"
    puts "checking cell #{row_index} #{col_index}"
    puts "filled_spots: #{filled_spots}"
    @reachable_rolls += 1 if filled_spots < 4
    puts "reachable_rolls: #{@reachable_rolls}"
  end

  def build_adjacent_cells(row_index, col_index)
    [
      { row: row_index - 1, col: col_index - 1 },
      { row: row_index - 1, col: col_index },
      { row: row_index - 1, col: col_index + 1 },
      { row: row_index, col: col_index - 1 },
      { row: row_index, col: col_index + 1 },
      { row: row_index + 1, col: col_index - 1 },
      { row: row_index + 1, col: col_index },
      { row: row_index + 1, col: col_index + 1 }
    ]
  end

  def get_file_path(is_test)
    path = is_test ? 'day_4_test' : 'day_4'
    "inputs/#{path}.txt"
  end
end

# ForkLift.new(is_test: true).perform
ForkLift.new(is_test: false).perform
