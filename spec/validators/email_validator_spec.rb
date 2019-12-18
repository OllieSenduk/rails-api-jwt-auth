require 'rails_helper'

describe EmailValidator do
    subject do 
        Class.new do 
            include ActiveModel::Validations
            attr_accessor :email
            validates :email, email: true
        end.new
    end

    context 'when the email is valid' do

        it 'is a valid with regular email' do
            should_be_valid('ollie.senduk@gmail.com')
        end

        it 'is valid with uncommon email' do
            should_be_valid('jane.doe@uncommon.co.uk')
        end
    end

    context 'when the email is invalid' do

        it 'is invalid with a .something at the end' do
            should_be_invalid('ollie.senduk@gmail')
        end

        it 'is invalid with a just a string' do
            should_be_invalid('helloworld')
        end

        it 'returns a message when email is invalid' do
            email = 'invalid'
            subject.email = email
            subject.valid?
            expect(subject.errors[:email]).to include('is not a valid email address')
        end
    end

    private

    def should_be_valid(email)
        email = email
        subject.email = email 
        expect(subject).to be_valid
    end

    def should_be_invalid(email)
        email = email
        subject.email = email 
        expect(subject).not_to be_valid
    end
end
