class UsersController < ApplicationController

  def signup
    user = User.new(user_params)
    if user.save
      render json: {status: 'SUCCESS', messege: 'Saved users', data:user},status: :ok
    else
      render json: {status: 'ERROR', message: 'User not saved', data: user.errors}, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.permit(:email, :password, :token)
    end
end
