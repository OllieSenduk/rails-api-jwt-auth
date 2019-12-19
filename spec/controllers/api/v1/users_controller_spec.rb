require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
    let(:user) {create(:user)}

    context 'CRUD actions' do
        context 'SHOW - should return a user' do
            before do 
                get api_v1_user_url(user.id), as: :json
            end

            it 'returns http 200 success' do
                expect(last_response.status).to eq 200
            end

            it 'should contain the correct information' do
                user_json = parse_response_json
                expect(user.email).to eq(user_json['email'])
            end
        end

        context 'CREATE - should create a new user' do
            it 'creates a new user' do 
                post api_v1_users_url, 
                {
                    user: {
                        email: 'new-user@test.com',
                        password: '12345678',
                    }
                }, as: :json
                expect(last_response.status).to eq 201
                expect(User.last.email).to eq('new-user@test.com')
            end

            it 'will not create a user if the email is taken' do
                post api_v1_users_url, 
                    {
                        user: {
                            email: user.email,
                            password: '12345678',
                            something: 'testing'
                        }
                    }, as: :json

                expect(last_response.status).to eq 422
            end
        end
    end
end
