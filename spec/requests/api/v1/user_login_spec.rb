require 'rails_helper'

describe 'Sessions API' do
  describe 'user login process' do
    before :each do
    @current_user = User.create(email: 'whatever@example.com',
                                password: 'password',
                                password_confirmation: 'password')
    end

    it "can login to user account" do
    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    login_params = {
      'email': 'whatever@example.com',
      'password': 'wrongpassword'
    }
    params_body = JSON.generate(login_params)


    post '/api/v1/sessions', headers: headers, params: params_body

    expect(response).to be_successful

    # var = JSON.parse(response.body, symbolize_names: true)
    require "pry"; binding.pry

    end

    xit "can fail to create account" do

    headers = {
      'CONTENT-TYPE' => 'application/json',
      'ACCEPT' => 'application/json'
    }

    create_params = {
      # 'email': 'whatever@example.com',
      'password': 'password',
      'password_confirmation': '42069'
    }

    params_body = JSON.generate(create_params)

    post '/api/v1/users', headers: headers, params: params_body

    expect(response.body).to eq("ERROR: email can't be blank; password_confirmation doesn't match Password")
    expect(response.status).to eq 400
    end
  end
end
