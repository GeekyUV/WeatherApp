require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end

    it 'fetches weather data successfully' do
      allow(RestClient).to receive(:get).and_return(
        double(:response, body: '{"cod": 200, "main": {"temp": 25, "humidity": 60, "pressure": 1010}, "weather": [{"description": "Cloudy"}]}')
      )

      get :index, params: { city: 'London' }

      expect(assigns(:temperature)).to eq(25)
      expect(assigns(:description)).to eq('Cloudy')
    end

    it 'handles API error gracefully with specific message' do
      error_response_body = 'Error response from the API'
      allow(RestClient).to receive(:get).and_return(
        double(:response, body: '{"cod": 404, "message": "City not found"}')
      )

      get :index, params: { city: 'NonexistentCity' }

      expect(assigns(:error_message)).to be_present
      expect(assigns(:temperature)).to be_nil
      expect(assigns(:description)).to be_nil

      error_message = JSON.parse(assigns(:error_message))['message']
      expect(error_message).to eq(error_response_body).or(eq('City not found'))
    end

    it 'handles API error gracefully with generic error message' do
      error_response_body = 'Generic error response from the API'

      allow(RestClient).to receive(:get).and_raise(RestClient::ExceptionWithResponse.new(
        double(:response, body: error_response_body, code: 500)
      ))

      get :index, params: { city: 'SomeCity' }

      expect(assigns(:error_message)).to be_present
      expect(assigns(:temperature)).to be_nil
      expect(assigns(:humidity)).to be_nil
      expect(assigns(:pressure)).to be_nil
      expect(assigns(:description)).to be_nil

      expect(JSON.parse(assigns(:error_message))['message']).to eq(error_response_body)
    end

    it 'handles JSON parsing error gracefully' do
      allow(RestClient).to receive(:get).and_return(double(:response, body: 'Invalid JSON'))

      get :index, params: { city: 'London' }

      expect(assigns(:error_message)).to match(/Error parsing response/)
      expect(assigns(:temperature)).to be_nil
      expect(assigns(:description)).to be_nil
    end

    it 'handles standard error gracefully' do
      allow(RestClient).to receive(:get).and_raise(StandardError.new('Something went wrong'))

      get :index, params: { city: 'London' }

      expect(assigns(:error_message)).to match(/An error occurred/)
      expect(assigns(:temperature)).to be_nil
      expect(assigns(:description)).to be_nil
    end
  end
end
