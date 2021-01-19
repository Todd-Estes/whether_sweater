require 'rails_helper'

describe 'Roadtrip API' do
  before :each do
  @current_user = User.create(email: 'whatever@example.com',
                              password: 'password',
                              password_confirmation: 'password')
  end

  it 'user can get roadtrip data' do
  headers = {
    'CONTENT-TYPE' => 'application/json',
    'ACCEPT' => 'application/json'
  }
  body = {
    "origin": "Denver,CO",
    "destination": "Pueblo, CO",
    "api_key": "#{@current_user.api_key}"
  }
  post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

  expect(response).to be_successful
  expect(response.status).to eq(200)
  roadtrip = JSON.parse(response.body, symbolize_names: true)

  expect(roadtrip).to be_a(Hash)
  expect(roadtrip).to have_key(:data)
  expect(roadtrip[:data]).to be_a(Hash)
  expect(roadtrip[:data]).to have_key(:id)
  expect(roadtrip[:data][:id]).to eq(nil)
  expect(roadtrip[:data]).to have_key(:type)
  expect(roadtrip[:data][:type]).to be_a(String)
  expect(roadtrip[:data]).to have_key(:attributes)
  expect(roadtrip[:data][:attributes]).to be_a(Hash)

  expect(roadtrip[:data][:attributes]).to have_key(:start_city)
  expect(roadtrip[:data][:attributes][:start_city]).to be_a(String)
  expect(roadtrip[:data][:attributes]).to have_key(:end_city)
  expect(roadtrip[:data][:attributes][:end_city]).to be_a(String)
  expect(roadtrip[:data][:attributes]).to have_key(:travel_time)
  expect(roadtrip[:data][:attributes][:travel_time]).to be_a(String)
  expect(roadtrip[:data][:attributes]).to have_key(:weather_at_eta)
  expect(roadtrip[:data][:attributes][:weather_at_eta]).to be_a(Hash)

  expect(roadtrip[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
  expect(roadtrip[:data][:attributes][:weather_at_eta][:temperature]).to be_a(Float)
  expect(roadtrip[:data][:attributes][:weather_at_eta]).to have_key(:conditions)
  expect(roadtrip[:data][:attributes][:weather_at_eta][:conditions]).to be_a(String)
  #TESTING FOR UNNECESSARY DATA HERE
  #
  #
  #
  #
  #TESTING FOR VCR HERE
  #
  #
  #
  #
  #
  end

  it 'can enter a destination unreachable by automobile and receive travel_time as impossible and empty weather_at_eta hash' do
    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    body = {
      "origin": "Denver,CO",
      "destination": "London",
      "api_key": "#{@current_user.api_key}"
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    roadtrip = JSON.parse(response.body, symbolize_names: true)

    expect(roadtrip).to be_a(Hash)
    expect(roadtrip).to have_key(:data)
    expect(roadtrip[:data]).to be_a(Hash)
    expect(roadtrip[:data]).to have_key(:id)
    expect(roadtrip[:data][:id]).to eq(nil)
    expect(roadtrip[:data]).to have_key(:type)
    expect(roadtrip[:data][:type]).to be_a(String)
    expect(roadtrip[:data]).to have_key(:attributes)
    expect(roadtrip[:data][:attributes]).to be_a(Hash)

    expect(roadtrip[:data][:attributes]).to have_key(:start_city)
    expect(roadtrip[:data][:attributes][:start_city]).to be_a(String)
    expect(roadtrip[:data][:attributes]).to have_key(:end_city)
    expect(roadtrip[:data][:attributes][:end_city]).to be_a(String)
    expect(roadtrip[:data][:attributes]).to have_key(:travel_time)
    expect(roadtrip[:data][:attributes][:travel_time]).to be_a(String)
    expect(roadtrip[:data][:attributes][:travel_time]).to eq("impossible")
    expect(roadtrip[:data][:attributes]).to have_key(:weather_at_eta)
    expect(roadtrip[:data][:attributes][:weather_at_eta]).to eq(nil)
  end

  it 'can forgo API key in params body and get Unauthorized error' do
    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    body = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO"
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    expect(response.status).to eq(401)
    expect(response.body).to eq("Unauthorized: invalid or missing token")
  end

  it 'can enter incorrect key in params body and get Unauthorized error' do
    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    body = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "1234567890123456789012345678"
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    expect(response.status).to eq(401)
    expect(response.body).to eq("Unauthorized: invalid or missing token")
  end

  it 'can forgo destination in params body and receive error message' do
    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    body = {
      "origin": "Denver,CO",
      "destination": "",
      "api_key": "#{@current_user.api_key}"
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    expect(response.status).to eq(400)
    expect(response.body).to eq("ERROR: At least two locations must be provided.")
  end

  it 'can digits for location in params body and and receive travel_time as impossible and empty weather_at_eta hash' do
    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }
    body = {
      "origin": "Denver,CO",
      "destination": "00000000",
      "api_key": "#{@current_user.api_key}"
    }
    post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

    expect(response).to be_successful
    expect(response.status).to eq(200)
    roadtrip = JSON.parse(response.body, symbolize_names: true)

    expect(roadtrip).to be_a(Hash)
    expect(roadtrip).to have_key(:data)
    expect(roadtrip[:data]).to be_a(Hash)
    expect(roadtrip[:data]).to have_key(:id)
    expect(roadtrip[:data][:id]).to eq(nil)
    expect(roadtrip[:data]).to have_key(:type)
    expect(roadtrip[:data][:type]).to be_a(String)
    expect(roadtrip[:data]).to have_key(:attributes)
    expect(roadtrip[:data][:attributes]).to be_a(Hash)

    expect(roadtrip[:data][:attributes]).to have_key(:start_city)
    expect(roadtrip[:data][:attributes][:start_city]).to be_a(String)
    expect(roadtrip[:data][:attributes]).to have_key(:end_city)
    expect(roadtrip[:data][:attributes][:end_city]).to be_a(String)
    expect(roadtrip[:data][:attributes]).to have_key(:travel_time)
    expect(roadtrip[:data][:attributes][:travel_time]).to be_a(String)
    expect(roadtrip[:data][:attributes][:travel_time]).to eq("impossible")
    expect(roadtrip[:data][:attributes]).to have_key(:weather_at_eta)
    expect(roadtrip[:data][:attributes][:weather_at_eta]).to eq(nil)
  end
end
