require 'rails_helper'
require 'pry'
class MockController 
    include Authenticable 
    attr_accessor :request

    def initialize
        mock_request = Struct.new(:headers) 
        self.request = mock_request.new({})
    end 
end

describe Authenticable do
    let! (:user) { create(:user) }
    let! (:authentication) { MockController.new }

    it 'should derive a user from the Authorization Token' do
        authentication.request.headers['Authorization'] = JsonWebToken.encode(user_id: user.id)
        expect(user.id).to eq(authentication.current_user.id)
    end

    it 'should not return a user when Authorization Token is not present' do
        authentication.request.headers['Authorization'] = nil
        expect(authentication.current_user).to be_nil
    end
end