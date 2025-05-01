require 'rails_helper'

RSpec.describe 'POST /api/v1/login', type: :request do
  let!(:user) do
    User.create!(
      name: 'Login Test',
      email: 'login_test@example.com',
      password: 'password123',
      password_confirmation: 'password123'
    )
  end

  let(:headers) { { 'Content-Type' => 'application/json' } }

  describe '正常系' do
    it 'ログインに成功し、JWTを返す' do
      post '/api/v1/login', params: {
        email: user.email,
        password: 'password123'
      }.to_json, headers: headers

      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json['status']).to eq('success')
      expect(json['data']['token']).to be_present
    end
  end

  describe '異常系' do
    it 'パスワードが間違っている場合は401を返す' do
      post '/api/v1/login', params: {
        email: user.email,
        password: 'wrongpassword'
      }.to_json, headers: headers

      expect(response).to have_http_status(:unauthorized)      
      json = JSON.parse(response.body)
      expect(json['status']).to eq('error')
      expect(json['errors']).to include('Invalid email or password')
    end

    it '存在しないメールアドレスでも401を返す' do
      post '/api/v1/login', params: {
        email: 'unknown@example.com',
        password: 'password123'
      }.to_json, headers: headers

      expect(response).to have_http_status(:unauthorized)
      json = JSON.parse(response.body)
      expect(json['status']).to eq('error')
    end

    it 'emailとpasswordが未入力の場合は422を返す' do
      post '/api/v1/login', params: {}.to_json, headers: headers

      expect(response).to have_http_status(:unauthorized)
      json = JSON.parse(response.body)
      expect(json['status']).to eq('error')
    end
  end
end