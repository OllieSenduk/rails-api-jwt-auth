require 'rails_helper'

describe Api::V1::UsersController, type: :controller do
    let(:user) {create(:user)}
    let(:bad_email) {'badmail.com'}

    describe 'CRUD actions' do
        describe 'get #show' do
            before do 
                get api_v1_user_url(user.id), as: :json
            end

            it 'returns http 200 success' do
                expect(last_response.status).to eq 200
            end

            it 'should contain the correct information' do
                user_json = parse_response_json
                expect(user.email).to eq(user_json['data']['attributes']['email'])
            end
        end

        describe 'post #create' do
            it 'creates a new user' do 
                post api_v1_users_url, 
                user_params, 
                as: :json

                expect(last_response.status).to eq 201
                expect(User.last.email).to eq('user@mail.com')
            end

            it 'will not create a user if the email is taken' do
                post api_v1_users_url, 
                user_params(email: user.email), 
                as: :json

                expect(last_response.status).to eq 422
            end

            it 'will not create a user with invalid fields' do
                post api_v1_users_url, 
                user_params(email: bad_email), 
                as: :json

                expect(last_response.status).to eq 422
            end
        end

        describe 'patch #update' do
            it 'should update a users fields' do
                patch api_v1_user_url(user.id), 
                user_params(email: 'new@test.com'),
                as: :json
                
                user.reload

                expect(last_response.status).to eq 200
                expect(user.email).to eq('new@test.com')
            end

            it 'should not update with invalid fields' do
                patch api_v1_user_url(user.id), 
                user_params(email: bad_email),
                as: :json

                user.reload

                expect(last_response.status).to eq 422
                expect(user.email).to eq('user@mail.com')
            end
        end

        describe 'delete #destroy' do
            it 'should delete a user' do
                user
                expect{
                    delete api_v1_user_url(user.id),
                    as: :json
                }.to change {User.count}.by(-1)
            end
        end
    end
end
