require 'rails_helper'

describe 'Forcast API' do
  it "can retrieve weather data for a city" do

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    get '/api/v1/forecast?location=denver,co', headers: headers

    expect(response).to be_successful

    expect(response).to have_key(:data)

    expect(response[:data]).to have_key(:id)
    expect(response[:data][:id]).to eq(nil)

    expect(response[:data]).to have_key(:type)
    expect(response[:data]).to be_a(String)
    expect(response[:data][:type]).to eq("forcast")

    expect(response[:data]).to have_key(:attributes)
    expect(response[:data][:attributes])

    end
  end
