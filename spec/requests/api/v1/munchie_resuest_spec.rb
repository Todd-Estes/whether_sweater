require 'rails_helper'

describe 'Munchie endpoint' do
  it 'user can get food and forecast data' do
  # headers = {
  #   'CONTENT-TYPE' => 'application/json',
  #   'ACCEPT' => 'application/json'
  # }
  get '/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese', headers: headers

  expect(response).to be_successful
  expect(response.status).to eq(200)

  munchie = JSON.parse(response.body, symbolize_names: true)
  expect(munchie).to be_a(Hash)
  expect(munchie).to have_key(:data)
  expect(munchie[:data]).to be_a(Hash)
  expect(munchie[:data]).to have_key(:id)
  expect(munchie[:data][:id]).to be(nil)
  expect(munchie[:data]).to have_key(:attributes)
  expect(munchie[:data][:attributes]).to be_a(Hash)
  expect(munchie[:data][:attributes]).to have_key(:destination_city)
  expect(munchie[:data][:attributes][:destination_city]).to be_a(String)
  expect(munchie[:data][:attributes]).to have_key(:travel_time)
  expect(munchie[:data][:attributes][:travel_time]).to be_a(String)
  expect(munchie[:data][:attributes]).to have_key(:forecast)
  expect(munchie[:data][:attributes][:forecast]).to be_a(Hash)
  expect(munchie[:data][:attributes][:forecast]).to have_key(:summary)
  expect(munchie[:data][:attributes][:forecast][:summary]).to be_a(String)
  expect(munchie[:data][:attributes][:forecast]).to have_key(:temperature)
  expect(munchie[:data][:attributes][:forecast][:temperature]).to be_a(String)
  expect(munchie[:data][:attributes]).to have_key(:restaurant)
  expect(munchie[:data][:attributes][:restaurant]).to be_a(Hash)
  expect(munchie[:data][:attributes][:restaurant]).to have_key(:name)
  expect(munchie[:data][:attributes][:restaurant][:name]).to be_a(String)
  expect(munchie[:data][:attributes][:restaurant]).to have_key(:address)
  expect(munchie[:data][:attributes][:restaurant][:address]).to be_a(String)

  end
end
