require_relative 'wheel'

class TheCracker
  attr_reader :encrypted_message, :the_wheel, :crack_rotator, :cracked_message, :crack_indices, :key_location, :end_of_message

  def initialize
    @encrypted_message = encrypted_message
    @the_wheel = Wheel.new
    @crack_rotator = []
    @crack_indices = []
    @cracked_message = cracked_message
    @key_location = key_location
    @end_of_message = [1, 1, 34, 25, 35, 1, 1]
  end

  def crack(encrypted_message, date = 2)
    @encrypted_message = encrypted_message.chars
    @key_location = encrypted_message.length
    7.times { @crack_rotator << @encrypted_message.pop }
    @crack_rotator.reverse!
    @crack_rotator.map! { |char| the_wheel.wheel.reverse.index(char) }
    compute_rotator
    find_rotator_position
    print_cracked_message
  end

  def compute_rotator
    difference = []
    difference = @crack_rotator.zip(end_of_message).map do |combined|
      combined.reduce do |rot, end_rot|
        if rot - end_rot < 0
          difference << rot - end_rot + 39
        else
          difference << rot - end_rot
        end
        @crack_rotator = difference
      end
    end
  end

  def find_rotator_position
    if key_location % 4 == 0
      @crack_rotator = @crack_rotator[-4..-1]
    elsif key_location % 4 == 1
      @crack_rotator = @crack_rotator[-5..-2]
    elsif key_location % 4 == 2
      @crack_rotator = @crack_rotator[-6..-3]
    else
      @crack_rotator = @crack_rotator[-7..-4]
    end
  end

  def print_cracked_message
    while encrypted_message.first != nil
      @crack_rotator.map do |key|
        @crack_indices << (key + the_wheel.wheel.index(encrypted_message.shift))
        break if encrypted_message.length == 0
      end
    end
    crack = @crack_indices.map do |index|
      the_wheel.wheel[index % 39]
    end
    @cracked_message = crack.join + '..end..'
  end
end

if __FILE__ == $0
  a = TheCracker.new
  puts a.encrypted_message
  puts a.crack("e32k7qr i7o77p3wp3off6v27qv1 99373wwq33x8t428n")
  puts a.crack_indices
  puts a.cracked_message
  puts a.crack_rotator
end
