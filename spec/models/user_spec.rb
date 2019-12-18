require 'rails_helper'

describe User, type: :model do
  let (:user) { build(:user) }
  let (:invalid_user) { build(:invalid_user) }

  context 'validations' do

    it 'is valid when email & password are present and correct' do
        expect(user.valid?).to be true
    end

    it 'is invalid when email is incorrect' do
        expect(invalid_user.valid?).to be false
    end

    it 'is invalid when email is taken' do
        user.save!
        new_user = User.new(email: user.email, password_digest: 'some_password')

        expect(new_user.valid?).to be false
    end
  end
end
