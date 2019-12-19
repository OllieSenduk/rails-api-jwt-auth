class Api::V1::UsersController < ApplicationController
    def show
        render json: User.find(params[:id]), status: 200
    end
end
