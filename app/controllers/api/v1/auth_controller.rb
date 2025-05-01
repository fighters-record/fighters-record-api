# app/controllers/api/v1/auth_controller.rb
module Api
  module V1
    # 認証コントローラ
    class AuthController < ApplicationController
      include ResponseHelper
      skip_before_action :authorize_request, only: [:create]
      def create
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: user.id)
          user.update(last_login_at: Time.current)

          render_success({ token: token })
        else
          render_error('Invalid email or password', status: :unauthorized)
        end
      end
    end
  end
end
