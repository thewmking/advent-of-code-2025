class Dial
  DIR_L = 'L'.freeze
  DIR_R = 'R'.freeze

  def initialize(is_test: false)
    @file_path = get_file_path(is_test)
    @rotations = load_rotations
    @pointer = 50
    @zeroes = 0
  end

  def perform
    @rotations.each do |r|
      turn(r[:dir], r[:num])
    end

    puts "final zero count: #{@zeroes}"
  end

  def load_rotations
    File.readlines(@file_path).map(&:chomp).map do |line|
      dir = line[0]
      num = line[1..]
      { dir: dir.to_s, num: num.to_i }
    end
  end

  def turn(dir, num)
    puts "turning dial #{dir}#{num} from #{@pointer}"

    case dir
    when DIR_L
      turn_left(num)
    when DIR_R
      turn_right(num)
    end

    return unless @pointer.zero?

    puts 'pointer is zero. increasing zero count'
    @zeroes += 1
  end

  def turn_left(num)
    @pointer -= num
    @pointer += 100 while @pointer < 0
  end

  def turn_right(num)
    @pointer += num
    @pointer -= 100 while @pointer > 99
  end

  def get_file_path(is_test)
    path = is_test ? 'day_1_test' : 'day_1'
    "inputs/#{path}.txt"
  end
end

# Dial.new(is_test: true).perform
Dial.new(is_test: false).perform
