require 'rails_helper'

describe 'Users API' do
  it "can create a user account" do

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    params = {
      'email': 'whatever@example.com',
      'password': 'password',
      'password_confirmation': 'password'
    }

    post '/api/v1/users', params, headers: headers

    expect(response).to be_successful

    end
  end
