require 'securerandom'

class Background
  attr_reader :id, :url

  def initialize(background_data)
    @url = background_data[:results][0][:urls][:raw]
    @id = SecureRandom.hex(10)
  end
end