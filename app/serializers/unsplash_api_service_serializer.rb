class UnsplashApiServiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :get_background_photo_url
end
