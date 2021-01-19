require 'rails_helper'

describe 'Users Endpoint' do
  describe 'user account creation' do
    it "can create a user account" do
      headers = {
        'CONTENT-TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      body = {
        'email': 'whatever@example.com',
        'password': 'password',
        'password_confirmation': 'password'
      }
      post '/api/v1/users', headers: headers, params: JSON.generate(body)

      expect(response).to be_successful
      verification = JSON.parse(response.body, symbolize_names: true)

      expect(verification).to be_a(Hash)
      expect(verification).to have_key(:data)
      expect(verification[:data]).to be_a(Hash)
      expect(verification[:data]).to have_key(:id)
      expect(verification[:data][:id]).to be_a(String)
      expect(verification[:data]).to have_key(:type)
      expect(verification[:data][:type]).to be_a(String)
      expect(verification[:data]).to have_key(:attributes)
      expect(verification[:data][:attributes]).to be_a(Hash)
      expect(verification[:data][:attributes]).to have_key(:email)
      expect(verification[:data][:attributes][:email]).to be_a(String)
      expect(verification[:data][:attributes]).to have_key(:api_key)
      expect(verification[:data][:attributes][:api_key]).to be_a(String)
    end

    it "can leave out email and mismatch password and get multiple errors" do
      headers = {
        'CONTENT-TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      body = {
        'password': 'password',
        'password_confirmation': 'wrongpassword'
      }
      post '/api/v1/users', headers: headers, params: JSON.generate(body)

      expect(response.body).to eq("ERROR:password_confirmation doesn't match Password; email can't be blank; ")
      expect(response.status).to eq 400
    end

    it "can leave out email and get error" do
      headers = {
        'CONTENT-TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      body = {
        'password': 'password',
        'password_confirmation': 'password'
      }
      post '/api/v1/users', headers: headers, params: JSON.generate(body)

      expect(response.body).to eq("ERROR:email can't be blank; ")
      expect(response.status).to eq 400
    end

    it "can mismatch passwords and get error" do
      headers = {
        'CONTENT-TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      body = {
        'email': 'fake@example.com',
        'password': 'password',
        'password_confirmation': 'wrongpassword'
      }
      post '/api/v1/users', headers: headers, params: JSON.generate(body)

      expect(response.body).to eq("ERROR:password_confirmation doesn't match Password; ")
      expect(response.status).to eq 400
    end

    it "can submit a non-unique email and receive error" do
      #COULD BE REFACTORED WITH BEFORE (:CONTEXT)
      headers = {
        'CONTENT-TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      body = {
        'email': 'whatever@example.com',
        'password': 'password',
        'password_confirmation': 'password'
      }
      post '/api/v1/users', headers: headers, params: JSON.generate(body)
    #COULD BE REFACTORED WITH BEFORE (:CONTEXT)
      headers = {
        'CONTENT-TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
      body = {
        'email': 'whatever@example.com',
        'password': 'password',
        'password_confirmation': 'password'
      }
      post '/api/v1/users', headers: headers, params: JSON.generate(body)

      expect(response.body).to eq("ERROR:email has already been taken; ")
      expect(response.status).to eq 400
    end
  end
end
