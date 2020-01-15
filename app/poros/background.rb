require 'securerandom'

class Background
  attr_reader :id, :url

  def initialize(background_data)
    @url = return_bg_or_error(background_data)
    @id = SecureRandom.hex(10)
  end

  def return_bg_or_error(background_data)
    if background_data[:results] != []
      background_data[:results][0][:urls][:raw]
    else
      return "https://images.unsplash.com/photo-1557862471-150b86c49ca1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1866&q=80"
    end
  end
end