# アプリケーションコントローラ
class ApplicationController < ActionController::API
  include ResponseHelper

  before_action :authorize_request

  private

  def authorize_request
    token = request.headers['Authorization']&.split(' ')&.last
    decoded = JsonWebToken.decode(token)
    @current_user = User.find(decoded[:user_id]) if decoded
  rescue StandardError
    render_error('Not authorized', status: :forbidden)
  end
end
