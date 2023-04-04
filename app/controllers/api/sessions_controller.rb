class Api::SessionsController < ApplicationController
    def index
        user= User.where(email: params[:email]).first
        if user&.valid_password?(params[:password])
            sign_in(:user, user)
      render json: {
        messages: "Signed In Successfully",
        is_success: true,
        data: {user: user}
      }, status: :ok
    else
      render json: {
        messages: "Signed In Failed - Unauthorized",
        is_success: false,
        data: {}
      }, status: :unauthorized
        end
    end
 
    





end