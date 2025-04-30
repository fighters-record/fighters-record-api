module Api
  module V1
    # ユーザーコントローラ
    class UsersController < ApplicationController
      include ResponseHelper

      def show
        user = User.find(params[:id])
        render_success(user)
      end

      def fail
        render_error('ユーザーが見つかりません', status: :not_found)
      end
    end
  end
end
