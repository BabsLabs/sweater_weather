class Api::V1::AntipodeController < ApplicationController

  def show
    location = GoogleAPIService.new(params[:location], nil)

    antipode = AntipodeService.new(location.latitude_and_longitude)

    antipode_info_for_google_reverse_lookup = antipode.antipode_info[:data][:attributes]

    antipode_city_info = GoogleAPIService.new(nil , antipode_info_for_google_reverse_lookup)

    antipode_info_for_google_reverse_lookup[:lng] = antipode_info_for_google_reverse_lookup[:long]

    forecast_results = DarkSkyAPIService.new(antipode_info_for_google_reverse_lookup)

    antipode_facade = AntipodeForecastFacade.new(forecast_results)

  end

end