require 'rails_helper'

RSpec.describe "Api::V1::Users", type: :request do
  describe "create" do
    it "can create an user" do 
      expect {
        post '/api/v1/users', params: {name: 'salt', email:'salt@test.com'}
      }.to change {User.count}.by 1
      expect(response).to have_http_status 200
      json = JSON.parse response.body
      expect(json['id']).to be_an(Numeric)
      expect(json['name']).to eq 'salt'
    end
  end
end
