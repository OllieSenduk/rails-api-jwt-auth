module Params
    module UserParams
        def user_params(email: 'user@mail.com', password:'hashed_password')
            {
                user: {
                    email: email,
                    password: password,
                }
            }
        end

    end
  end
  