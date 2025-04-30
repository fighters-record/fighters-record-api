require 'rails_helper'

RSpec.describe 'Api::V1::Health', type: :request do
  describe 'GET /api/v1/health' do
    it 'returns 200 OK' do
      get_with_host '/api/v1/health', headers: { 'ACCEPT' => 'application/json', 'HOST' => 'localhost' }
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('ok') # 必要に応じて適宜変更
    end
  end
end
