require 'rails_helper'
require 'net/http'
require 'json'

RSpec.describe 'API Login Flow', type: :request do
  let(:host) { ENV.fetch('API_HOST', 'http://localhost:3000') }
  let(:email) { "scenario_user_#{Time.now.to_i}@example.com" }
  let(:password) { 'password123' }

  it 'creates a user and logs in with JWT' do
    # Step 1: ユーザー作成
    uri = URI("#{host}/api/v1/users")
    user_payload = {
      user: {
        name: 'シナリオ太郎',
        email: email,
        password: password,
        password_confirmation: password
      }
    }

    res = Net::HTTP.post(uri, user_payload.to_json, 'Content-Type' => 'application/json')
    expect(res).not_to be_nil
    expect(res.code).to eq('201'), "Expected 201 Created, got #{res.code} - #{res.body}"

    # Step 2: ログインしてトークン取得
    uri = URI("#{host}/api/v1/login")
    login_payload = { email: email, password: password }
    res = Net::HTTP.post(uri, login_payload.to_json, 'Content-Type' => 'application/json')
    expect(res).not_to be_nil
    expect(res.code).to eq('200'), "Expected 200 OK, got #{res.code} - #{res.body}"

    body = JSON.parse(res.body)
    expect(body.dig('data', 'token')).to be_present, "Login succeeded but token missing: #{body}"
  end
end
