require 'rails_helper'

describe 'Sessions API', :vcr do
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
        'password': 'password'
      }
      params_body = JSON.generate(login_params)
      post '/api/v1/sessions', headers: headers, params: params_body

      expect(response).to be_successful
      expect(response.status).to eq(200)

      login_response = JSON.parse(response.body, symbolize_names: true)

      expect(login_response).to be_a(Hash)
      expect(login_response).to have_key(:data)
      expect(login_response[:data]).to be_a(Hash)
      expect(login_response[:data]).to have_key(:id)
      expect(login_response[:data][:id]).to be_a(String)
      expect(login_response[:data]).to have_key(:type)
      expect(login_response[:data][:type]).to be_a(String)
      expect(login_response[:data]).to have_key(:attributes)
      expect(login_response[:data][:attributes]).to be_a(Hash)
      expect(login_response[:data][:attributes]).to have_key(:email)
      expect(login_response[:data][:attributes][:email]).to be_a(String)
      expect(login_response[:data][:attributes]).to have_key(:api_key)
      expect(login_response[:data][:attributes][:api_key]).to be_a(String)
    end

    it "can leave out email and enter incorrect password and get error" do
      headers = {
        'CONTENT-TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      login_params = {
        'password': 'fakepassword'
      }
      params_body = JSON.generate(login_params)

      post '/api/v1/sessions', headers: headers, params: params_body

      expect(response.body).to eq("ERROR: Cannot leave user email or password blank")
      expect(response.status).to eq 400
    end

    it "can leave out email and get error" do
      headers = {
        'CONTENT-TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      create_params = {
        'password': 'password',

      }
      params_body = JSON.generate(create_params)

      post '/api/v1/sessions', headers: headers, params: params_body

      expect(response.body).to eq("ERROR: Cannot leave user email or password blank")
      expect(response.status).to eq 400
    end

    it "can enter incorrect password and get error" do
      headers = {
        'CONTENT-TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      create_params = {
        'email': 'whatever@example.com',
        'password': 'wrongpassword'
      }
      params_body = JSON.generate(create_params)

      post '/api/v1/sessions', headers: headers, params: params_body

      expect(response.body).to eq("ERROR: Invalid email or password; unable to authenticate")
      expect(response.status).to eq 401
    end
    it "can not sumbit a password and receive error" do
      headers = {
        'CONTENT-TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      create_params = {
        'email': 'whatever@example.com',
      }
      params_body = JSON.generate(create_params)

      post '/api/v1/sessions', headers: headers, params: params_body

      expect(response.body).to eq("ERROR: Cannot leave user email or password blank")
      expect(response.status).to eq 400
    end
    it "can enter incorrect email and get authentication error" do
      headers = {
        'CONTENT-TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      create_params = {
        'email': 'fakeemail@example.com',
        'password': 'password'
      }
      params_body = JSON.generate(create_params)

      post '/api/v1/sessions', headers: headers, params: params_body

      expect(response.body).to eq("ERROR: Invalid email or password; unable to authenticate")
      expect(response.status).to eq 401
    end
   end
  end
