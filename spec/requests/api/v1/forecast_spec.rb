require 'rails_helper'

describe 'Forcast API' do
  it "can retrieve weather data for a city" do

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    get '/api/v1/forecast?location=denver,co', headers: headers

    expect(response).to be_successful


    weather_info = JSON.parse(response.body, symbolize_names:true)


    expect(weather_info).to have_key(:data)

    expect(weather_info[:data]).to have_key(:id)
    expect(weather_info[:data][:id]).to eq(nil)

    expect(weather_info[:data]).to have_key(:type)
    expect(weather_info[:data][:type]).to be_a(String)
    expect(weather_info[:data][:type]).to eq("forecast")

    expect(weather_info[:data]).to have_key(:attributes)
    expect(weather_info[:data][:attributes]).to be_a(Hash)

    end
  end
