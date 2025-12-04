class JoltageChecker
  def initialize(is_test: false)
    @banks = load_battery_banks(is_test)
    @max_joltages = []
  end

  def load_battery_banks(is_test)
    File.readlines(get_file_path(is_test)).map(&:chomp)
  end

  def perform
    @banks.each do |b|
      find_max_joltage(b)
    end
    puts 'max joltages: '
    puts @max_joltages
    puts "total: #{@max_joltages.sum}"
  end

  def find_max_joltage(bank)
    possible_maxes = [standard_max(bank), substring_max(bank)]
    @max_joltages << possible_maxes.max
  end

  def standard_max(bank)
    # this only works sometimes
    max_nums = bank.chars.map(&:to_i).sort.last(2)
    max_nums.sort_by { |n| bank.index(n.to_s) }.join.to_i
  end

  def substring_max(bank)
    max_num = bank.chars.map(&:to_i).max
    substring = bank.slice(bank.index(max_num.to_s)..)
    max_nums = substring.chars.map(&:to_i).sort.last(2)
    max_nums.sort_by { |n| substring.index(n.to_s) }.join.to_i
  end

  def get_file_path(is_test)
    path = is_test ? 'day_3_test' : 'day_3'
    "inputs/#{path}.txt"
  end
end

# JoltageChecker.new(is_test: true).perform
JoltageChecker.new(is_test: false).perform
