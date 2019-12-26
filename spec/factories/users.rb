FactoryBot.define do
  factory :user do
    email { "user@mail.com" }
    password_digest { BCrypt::Password.create('hashed_password') }
  end

  factory :invalid_user, class: User do
    email { "invalid_email" }
    password_digest { BCrypt::Password.create('hashed_password') }
  end
end
