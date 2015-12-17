class Wheel
  attr_reader :wheel

  def initialize
    @wheel = "abcdefghijklmnopqrstuvwxyz0123456789 .,".chars
  end
end
