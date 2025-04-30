require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  describe 'POST /api/v1/users' do
    let(:valid_params) do
      {
        user: {
          name: 'テスト太郎',
          email: "user_#{SecureRandom.hex(4)}@example.com",
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end

    it 'creates a user with valid params' do
      post '/api/v1/users', params: valid_params, as: :json, headers: { 'HOST' => 'localhost' }
      puts response.body  # ← ここ追加
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['data']['email']).to eq(valid_params[:user][:email])
    end

    it 'returns 422 with invalid email' do
      post '/api/v1/users', params: valid_params.deep_merge(user: { email: '' }), as: :json, headers: { 'HOST' => 'localhost' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include("Email can't be blank")
    end

    it 'returns 422 when password too short' do
      post '/api/v1/users', params: valid_params.deep_merge(user: { password: '123' }), as: :json, headers: { 'HOST' => 'localhost' }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors'].join).to match(/Password/)
    end
  end
end