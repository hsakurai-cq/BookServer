class ApplicationController < ActionController::API

  def authenticate_user!
    if current_user = User.find_by(token: request.headers[:Authorization])
      @current_user = current_user
    else
      render json: {status: 401, error: "No Authorization"}, status: :unauthorized
    end
  end

  def render_json_success(object)
    render json: {status: 200, result: object},status: :ok
  end

  def render_json_failure(message)
    render json: {status: 422, message: message}, status: :unprocessable_entity
  end
end
