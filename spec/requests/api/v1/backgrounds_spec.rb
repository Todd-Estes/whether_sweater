require 'rails_helper'

describe 'Backgrounds API', :vcr do
  it "can retrieve an image for a city" do

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    get '/api/v1/backgrounds?location=denver,co', headers: headers

    expect(response).to be_successful

    image_info = JSON.parse(response.body, symbolize_names:true)

    expect(image_info).to have_key(:data)
    expect(image_info[:data]).to be_a(Hash)

    expect(image_info[:data]).to have_key(:id)
    expect(image_info[:data][:id]).to eq(nil)

    expect(image_info[:data]).to have_key(:type)
    expect(image_info[:data][:type]).to be_a(String)
    expect(image_info[:data][:type]).to eq("image")

    expect(image_info[:data]).to have_key(:attributes)
    expect(image_info[:data][:attributes]).to be_a(Hash)


    expect(image_info[:data][:attributes]).to be_a(Hash)
    expect(image_info[:data][:attributes]).to have_key(:image)

    expect(image_info[:data][:attributes][:image]).to be_a(Hash)
  end

  it "can not enter anything and get an 400 status error message" do

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    get '/api/v1/backgrounds?location=', headers: headers


    expect(response.status).to eq(400)
    expect(response.body).to eq("ERROR: Location entry cannot be blank")
  end
end
