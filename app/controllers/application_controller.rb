class ApplicationController < ActionController::API

  def authenticate_user!
    if current_user = User.find_by(token: request.headers[:Authorization])
      @current_user = current_user
    else
      render json: {error: "Bad request"}, status: :bad_request
    end
  end
end
