require 'rest-client'
require 'json'

class GetGoogleCoffeeListService
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def call
    begin
      location = "location=-#{@latitude},#{@longitude}"
      radius   = 'radius=5000'
      key      = "key=#{Rails.application.credentials.google_secret_key}"
      base_url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=coffee+shop&#{location}&#{radius}&#{key}"
      response = RestClient.get base_url
      JSON.parse(response.body)
    rescue RestClient::ExceptionWithResponse => e
      e.response
    end
  end
end