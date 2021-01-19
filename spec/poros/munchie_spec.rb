require 'rails_helper'

describe 'Munchie' do
  it 'exists' do
    params = {'start': 'denver,co',
              'end': 'pueblo,co',
              'food': 'chinese'}
    munchie = Munchie.new
    expect(munchie).to be_a(Munchie)
    expect(munchie.id).to be_nil
    expect(munchie.travel_time).to be_a(String)
    expect(munchie.destination_city).to be_a(String)
    expect(munchie.forecast).to be_a(Hash)
    expect(munchie.forecast).to have_key(:summary)
    expect(munchie.forecast[:summary]).to be_a(String)
    expect(munchie.forecast).to have_key(:temperature)
    expect(munchie.forecast[:temperature]).to be_a(String)
    expect(munchie.restaurant).to have_key(:name)
    expect(munchie.restaurant[:name]).to be_a(String)
    expect(munchie.restaurant).to have_key(:address)
    expect(munchie.restaurant[:address]).to be_a(String)
  end
end
