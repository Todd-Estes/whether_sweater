require 'rails_helper'

describe 'Users API' do
  it "can create a user account" do

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    create_params = {
      'email': 'whatever@example.com',
      'password': 'password',
      'password_confirmation': 'password'
    }

    params_body = JSON.generate(create_params)

    post '/api/v1/users', headers: headers, params: params_body

    expect(response).to be_successful
    var = JSON.parse(response.body, symbolize_names: true)
    end

    it "can fail to create account" do

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    create_params = {
      # 'email': 'whatever@example.com',
      'password': 'password',
      'password_confirmation': '420'
    }

    params_body = JSON.generate(create_params)

    post '/api/v1/users', headers: headers, params: params_body

    expect(response.body).to eq("ERROR: password_confirmation doesn't match Password; email can't be blank")
    expect(response.status).to eq 400
  end
end
