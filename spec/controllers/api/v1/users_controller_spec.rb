require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
    let(:user) {create(:user)}

    context 'CRUD actions' do
        context 'SHOW - should return a user' do

            before do 
                get api_v1_user_url(user.id), as: :json
            end

            it 'returns http 200 success' do
                expect(response.status).to eq 200
            end

            it 'should contain the correct information' do
                user_json = parse_response_json
                expect(user.email).to eq(user_json['email'])
            end
        end
    end
end
