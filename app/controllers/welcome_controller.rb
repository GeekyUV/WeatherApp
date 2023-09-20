class WelcomeController < ApplicationController
  require 'rest-client'
  require 'json'

  def index
    city = params[:city]
    if city.present?
      api_key = '7677c2ddb805607e89bfa43410d854b9' # Replace with your OpenWeatherMap API key
      endpoint = "https://api.openweathermap.org/data/2.5/weather?q=#{city}&units=metric&appid=#{api_key}"

      begin
        response = RestClient.get(endpoint)
        weather_data = JSON.parse(response.body)

        if weather_data['cod'] == 200
          @temperature = weather_data['main']['temp']
          @humidity = weather_data['main']['humidity']
          @pressure = weather_data['main']['pressure']
          @description = weather_data['weather'][0]['description']
          @error_message = nil
        else
          @error_message = { message: "City not found" }.to_json
        end
      rescue RestClient::ExceptionWithResponse => e
        @error_message = { message: e.response.body }.to_json
      rescue JSON::ParserError => e
        @error_message = { message: "Error parsing response: #{e.message}" }.to_json
      rescue StandardError => e
        @error_message = { message: "An error occurred: #{e.message}" }.to_json
      end
    end

    if @temperature.blank? || @description.blank?
      @no_data_message = "No data available for #{city}" if city.present?
    end
  end
end
