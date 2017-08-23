class ApplicationController < ActionController::API

  def authenticate_user!
    if current_user = User.find_by(token: request.headers[:Authorization])
      @current_user = current_user
    else
      render json: {code: 401, error: "No Authorization"}, status: :unauthorized
    end
  end

  def render_user_action_success(object)
    render json: {code: 200, result: UserSerializer.new(object)},status: :ok
  end

  def render_book_action_success(object)
    render json: {code: 200, result: BookSerializer.new(object)},status: :ok
  end

  def render_json_failure(message)
    render json: {code: 422, message: message}, status: :unprocessable_entity
  end
end
