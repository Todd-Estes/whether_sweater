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

    expect(response.body).to eq("ERROR:password_confirmation doesn't match Password; email can't be blank; ")
    expect(response.status).to eq 400
  end
end
# it "can leave out email and mismatch password and get error" do
#   headers = {
#     'CONTENT-TYPE' => 'application/json',
#     'ACCEPT' => 'application/json'
#   }
#   create_params = {
#     'password': 'password',
#     'password_confirmation': '42069'
#   }
#   params_body = JSON.generate(create_params)
#
#   post '/api/v1/sessions', headers: headers, params: params_body
#
#   expect(response.body).to eq("ERROR: password_confirmation doesn't match Password; email can't be blank")
#   expect(response.status).to eq 400
# end
#
# it "can leave out email and get error" do
#   headers = {
#     'CONTENT-TYPE' => 'application/json',
#     'ACCEPT' => 'application/json'
#   }
#   create_params = {
#     'password': 'password',
#     'password_confirmation': 'password'
#   }
#   params_body = JSON.generate(create_params)
#
#   post '/api/v1/sessions', headers: headers, params: params_body
#
#   expect(response.body).to eq("ERROR: email can't be blank")
#   expect(response.status).to eq 400
# end
#
# it "can mismatch passwords and get error" do
#   headers = {
#     'CONTENT-TYPE' => 'application/json',
#     'ACCEPT' => 'application/json'
#   }
#   create_params = {
#     'email': 'fake@example.com',
#     'password': 'password',
#     'password_confirmation': 'wrongpassword'
#   }
#   params_body = JSON.generate(create_params)
#
#   post '/api/v1/sessions', headers: headers, params: params_body
#
#   expect(response.body).to eq("ERROR: password_confirmation doesn't match Password")
#   expect(response.status).to eq 400
# end
# it "can submit a non-unique email and receive error" do
#   headers = {
#     'CONTENT-TYPE' => 'application/json',
#     'ACCEPT' => 'application/json'
#   }
#   create_params = {
#     'email': 'whatever@example.com',
#     'password': 'password',
#     'password_confirmation': 'password'
#   }
#   params_body = JSON.generate(create_params)
#
#   post '/api/v1/sessions', headers: headers, params: params_body
#
#   expect(response.body).to eq("ERROR: email has already been taken")
#   expect(response.status).to eq 400
# end
# end
# end
