class BackgroundFacade

  def self.find_background(location)
    background_data = UnsplashAPIService.get_background_photo_url(location)
    Background.new(background_data)
  end

end