class UsersController < ApplicationController

  def signup
    user = User.new(user_params)
    user.token = SecureRandom.uuid
    if user.save
      #render json: {status: 200, result: user},status: :ok
      render_json_success(user)
    else
      #render json: {status: 'ERROR', message: 'User not saved', data: user.errors}, status: :unprocessable_entity
      render_json_failure("Cannot signup")
    end
  end

  def login
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      #render json: {status: 200, result: user},status: :ok
      render_json_success
    else
      #render json: {status: 'ERROR', message: 'User not saved', data: user.errors}, status: :unprocessable_entity
      render_json_failure("Cannot login")
    end
  end

  private
    def user_params
      params.permit(:email, :password)
    end
end
