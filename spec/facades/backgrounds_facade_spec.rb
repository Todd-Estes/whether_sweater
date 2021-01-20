require 'rails_helper'

describe 'Backgrounds Facade', :vcr do
  it 'calls BackgroundService for location image data and create BackgroundImage poro' do
    location = 'denver,co'

    image_data = BackgroundService.get_image(location)
    background_object = BackgroundImage.new(image_data[:value][0], location)

    expect(background_object).to be_a(BackgroundImage)
    expect(background_object.id).to eq(nil)
    expect(background_object.image).to be_a(Hash)
    expect(background_object.image).to have_key(:location)
    expect(background_object.image[:location]).to be_a(String)
    expect(background_object.image).to have_key(:image_url)
    expect(background_object.image[:image_url]).to be_a(String)
    expect(background_object.image).to have_key(:credit)
    expect(background_object.image[:credit]).to be_a(Hash)
    expect(background_object.image[:credit]).to have_key(:source)
    expect(background_object.image[:credit][:source]).to be_a(String)
    expect(background_object.image[:credit]).to have_key(:author)
    expect(background_object.image[:credit][:author]).to be_a(String)
    expect(background_object.image[:credit]).to have_key(:logo)
    expect(background_object.image[:credit][:logo]).to be_a(String)
  end
end
