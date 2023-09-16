# frozen_string_literal: true

class GalleryController < ApplicationController
  API_KEY = '4dfc1816-b34f-4fd1-82fc-d0a0fe07515e'
  SECTION = 'image'

  include Pagy::Backend
  include Pagy::Frontend

  def index
    response = Faraday.get("https://api.harvardartmuseums.org/#{SECTION}?apikey=#{API_KEY}")

    # render json: JSON.parse(response.body)
    parsed_response = JSON.parse(response.body)['records'].pluck('baseimageurl')
    @next_page = Faraday.get(JSON.parse(response.body)['info']['next'])
    @prev_page = Faraday.get(JSON.parse(response.body)['info']['prev']) if response.body['info']['prev'].present?

    @pagy, @parsed_response = pagy_array(parsed_response, items: 10)
  end
end
