class IdChecker
  def initialize(is_test: false)
    @file_path = get_file_path(is_test)
    @id_ranges = load_id_ranges
    @invalids = []
  end

  def load_id_ranges
    File.read(@file_path).split(',')
  end

  def perform
    @id_ranges.each do |r|
      check_range(range_from_string(r))
    end
    puts 'invalids: '
    puts @invalids
    puts "total: #{@invalids.sum}"
  end

  def check_range(id_range)
    id_range.each do |id|
      @invalids << id if id_invalid?(id)
    end
  end

  def id_invalid?(id)
    id_str = id.to_s
    return false unless id_str.length.even?

    first, second = id_str.chars.each_slice(id_str.length / 2).map(&:join)
    first == second
  end

  def range_from_string(str)
    start_num, end_num = str.split('-').map(&:to_i)
    (start_num..end_num).to_a
  end

  def get_file_path(is_test)
    path = is_test ? 'day_2_test' : 'day_2'
    "inputs/#{path}.txt"
  end
end

# IdChecker.new(is_test: true).perform
IdChecker.new(is_test: false).perform
