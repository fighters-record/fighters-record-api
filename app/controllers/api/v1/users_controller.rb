# app/controllers/api/v1/users_controller.rb
module Api
  module V1
    # ユーザコントローラ
    class UsersController < ApplicationController
      include ResponseHelper

      def create
        user = User.new(user_params)
        if user.save
          render_success(user, status: :created)
        else
          render_error(user.errors.full_messages, status: :unprocessable_entity)
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
