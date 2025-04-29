# Rubyのベースイメージ（最新版安定系）
FROM ruby:3.3

# 必要なパッケージをインストール（Node.js + PostgreSQLクライアント）
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# 作業ディレクトリを設定
WORKDIR /app

# Gemfile・Gemfile.lock をコピーして bundle install（キャッシュ効かせるため先にコピー）
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

# 残りのソースコードをコピー
COPY . .

# ポートを公開
EXPOSE 3000

# Railsサーバ起動コマンド
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]
