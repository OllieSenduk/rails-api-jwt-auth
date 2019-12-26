require 'rails_helper'

RSpec.describe Api::V1::TokensController, type: :controller do
  
  let! (:user) { create(:user) }

  describe "post #create" do
    it "gets the JWT token with correct password" do
      post api_v1_tokens_url,
      user_params,
      as: :json

      expect(last_response.status).to eq(200)
      json_response = JSON.parse(last_response.body)
      
      expect(json_response['token']).to be_truthy
    end

    it "fails to give JWT token with wrong password" do 
      post api_v1_tokens_url,
      user_params(password: 'bad password'),
      as: :json

      expect(last_response.status).to eq 401
    end
  end



end
