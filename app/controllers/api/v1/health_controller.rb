module Api
  module V1
    # ヘルスチェック用API
    class HealthController < ApplicationController
      def index
        render json: { status: 'ok' }
      end
    end
  end
end
