class User < ApplicationRecord
include ActiveModel::Validations

    validates :email, uniqueness: true
    validates :email, email: true
    validates :password_digest, presence: true
end
