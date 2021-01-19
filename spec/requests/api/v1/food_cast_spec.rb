require 'rails_helper'

describe 'FoodCast endpoint' do
  it 'user can get food and forecast data' do
  # headers = {
  #   'CONTENT-TYPE' => 'application/json',
  #   'ACCEPT' => 'application/json'
  # }
  # body = {
  #   "origin": "Denver,CO",
  #   "destination": "Pueblo, CO",
  #   "api_key": "#{@current_user.api_key}"
  # }
  get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese', headers: headers

  expect(response).to be_successful
  expect(response.status).to eq(200)
  end
end
