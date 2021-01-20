require 'rails_helper'

describe 'Background Poro', :vcr do
  it "exists" do
    location = 'denver,co'
    image_data = BackgroundService.get_image(location)
    background_image= BackgroundImage.new(image_data[:value][0], location)

    expect(background_image).to be_a(BackgroundImage)
    expect(background_image.id).to eq(nil)
    expect(background_image.image).to be_a(Hash)
    expect(background_image.image).to have_key(:location)
    expect(background_image.image[:location]).to be_a(String)
    expect(background_image.image).to have_key(:image_url)
    expect(background_image.image[:image_url]).to be_a(String)
    expect(background_image.image).to have_key(:credit)
    expect(background_image.image[:credit]).to be_a(Hash)
    expect(background_image.image[:credit]).to have_key(:source)
    expect(background_image.image[:credit][:source]).to be_a(String)
    expect(background_image.image[:credit]).to have_key(:author)
    expect(background_image.image[:credit][:author]).to be_a(String)
    expect(background_image.image[:credit]).to have_key(:logo)
    expect(background_image.image[:credit][:logo]).to be_a(String)
  end
end
