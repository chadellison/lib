class KeyGenerator
  attr_reader :offset_key
  attr_accessor :current_key

  def initialize(current_key = nil, date = nil)
    @current_key = current_key
    @offset_key = offset_key
  end

  def random_number_generator
    key = []
    each_key_value = (0..9).to_a
    5.times do
      key << each_key_value.sample
    end
    key.join
  end

  def initial_key_values(the_keys = random_number_generator)
    key = []
    the_keys = the_keys.to_s.chars
    key << key_a = the_keys[0..1].join
    key << key_b = the_keys[1..2].join
    key << key_c = the_keys[2..3].join
    key << key_d = the_keys[3..4].join
    @current_key = key.map do |num|
      num.to_i
    end
  end

  def offset(date = nil)
    if date.nil?
      current_date = Time.now.strftime("%d%m%y")
    else
      current_date = date
    end
    current_date = current_date.to_i ** 2
    offset = current_date.to_s[-4..-1]
    offset = offset.chars.map do |number|
      number.to_i
    end
  end

  def key_generation(key = nil)
    if key == nil
      the_key = initial_key_values(random_number_generator)
    else
      the_key = initial_key_values(key)
    end
    @offset_key = the_key.zip(offset).map do |key|
      key.reduce(0, :+)
    end
  end
end

if __FILE__ == $0
  a = KeyGenerator.new
  a.key_generation(12345)
  puts a.current_key
  puts a.offset_key
end
