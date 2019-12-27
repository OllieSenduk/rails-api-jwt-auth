class Api::V1::UsersController < ApplicationController
    before_action :find_user, except: %[create]
    before_action :check_owner, only: %[update destroy]

    def show
        render_serialized_json
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render_serialized_json(:created)
        else
            render json: @user.errors.messages, status: :unprocessable_entity
        end
    end

    def update
        if @user.update(user_params)
            render_serialized_json
        else
            render json: @user.errors.messages, status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
        head 204
    end

    private

    def render_serialized_json(status= :ok)
        status = status.to_sym
        render json: UserSerializer.new(@user).serializable_hash, 
        status: status
    end

    def check_owner
        head :forbidden unless @user.id == current_user&.id
    end

    def user_params
        params.require(:user).permit(:email, :password)
    end

    def find_user
        @user = User.find(params[:id])
    end
end
