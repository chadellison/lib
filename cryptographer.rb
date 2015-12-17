require_relative 'key_generator'
require_relative 'wheel'

class Cryptographer
  attr_reader :the_wheel, :rotations, :decrypt_rotations, :encrypted_message, :decrypted_message, :the_key

  def initialize
    @the_key = KeyGenerator.new
    @the_wheel = Wheel.new
    @rotations = []
    @decrypt_rotations = []
    @encrypted_message = encrypted_message
    @decrypted_message = decrypted_message
  end

  def encryptor(message, key = nil, date = nil)
    secret_key = the_key.key_generation(key)
    message = message.to_s.downcase.chars
    while message.first != nil
      secret_key.map do |key|
        @rotations << (key + the_wheel.wheel.index(message.shift))
        break if message.length == 0
      end
    end
    encryption
  end

  def decryptor(message, key = key_generator, date = nil)
    secret_key = the_key.key_generation(key)
    message = message.to_s.downcase.chars
    while message.first != nil
      secret_key.map do |key|
        @decrypt_rotations << (key + the_wheel.wheel.reverse.index(message.shift))
        break if message.length == 0
      end
    end
    decryption
  end

  def encryption
    encryption = @rotations.map do |index|
      the_wheel.wheel[index % 39]
    end
    @encrypted_message = encryption.join
  end

  def decryption
    decryption = @decrypt_rotations.map do |index|
      the_wheel.wheel.reverse[index % 39]
    end
    @decrypted_message = decryption.join
  end
end
