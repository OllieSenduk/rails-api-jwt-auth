class Api::V1::UsersController < ApplicationController
    before_action :find_user, except: %[create]
    before_action :check_owner, only: %[update destroy]

    def show
        render json: @user, status: :ok
    end

    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user, status: :created
        else
            render json: @user.errors.messages, status: :unprocessable_entity
        end
    end

    def update
        if @user.update(user_params)
            render json: @user, status: :ok
        else
            render json: @user.errors.messages, status: :unprocessable_entity
        end
    end

    def destroy
        @user.destroy
        head 204
    end

    private

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
