class UsersController < ApplicationController

  def signup
    user = User.new(user_params)
    if user.save
      render_user_action_success(user)
    else
      render_json_failure("Cannot signup")
    end
  end

  def login
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      render_user_action_success(user)
    else
      render_json_failure("Cannot login")
    end
  end

  private
    def user_params
      params.permit(:email, :password)
    end
end
