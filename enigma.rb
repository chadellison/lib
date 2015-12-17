require_relative 'cryptographer'
require_relative 'the_cracker'

class Enigma
  attr_reader :key_generator, :current_date

  def initialize
    @key_generator = KeyGenerator.new
    @current_date = Time.now.strftime("%m%d%y")
  end

  def encrypt(message, key = nil, date = current_date)
    Cryptographer.new.encryptor(message, key, date = current_date)
  end

  def decrypt(message, key = nil, date = current_date)
    Cryptographer.new.decryptor(message, key, date = current_date)
  end

  def crack(encrypted_message, date = current_date)
    TheCracker.new.crack(encrypted_message)
  end
end
