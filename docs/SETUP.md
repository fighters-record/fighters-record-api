# fighters-record-api 開発環境構築ガイド

## ✅ 前提条件

- macOS (Apple Silicon / IntelどちらでもOK)
- Docker Desktop インストール済み
- Docker Compose v2 使用
- Git インストール済み

---

## 📦 セットアップ手順

### 1. リポジトリをクローン

```bash
git clone {your repository url}
cd fighters-record-api
```

---

### 2. Docker環境準備

fighters-record-api は Docker + docker-compose を利用して動作します。

#### 開発用（docker-compose.yml）

```bash
docker compose build --no-cache
docker compose up
```

- APIサーバ (Rails) → localhost:3000
- DB (PostgreSQL) → localhost:5432

#### 本番用（docker-compose.prod.yml）

```bash
docker compose -f docker-compose.prod.yml up --build
```

---

### 3. 初期セットアップ

コンテナが起動したら、以下を実行してDBを初期化します。

```bash
make db-create
make db-migrate
```

または手動で：

```bash
docker compose exec api rails db:create
docker compose exec api rails db:migrate
```

---

### 4. Makefile活用（便利コマンド集）

| コマンド | 内容 |
|:--|:--|
| `make up` | docker compose up |
| `make down` | docker compose down |
| `make build` | docker compose build |
| `make prod-up` | 本番ビルド＆起動 |
| `make bash` | コンテナに入る |
| `make db-create` | データベース作成 |
| `make db-migrate` | マイグレーション実行 |
| `make console` | Railsコンソールを起動 |
| `make logs` | コンテナのログを見る |

---

## 🛠 注意事項

- `.env`, `master.key` などの重要ファイルはコミット除外済み
- `.DS_Store`などのOSゴミファイルもignore対象
- `config/database.yml` はDocker用にhost=db指定済み
- Rubyバージョンは3.3.8、Railsバージョンは7.1を想定

---

# ✅ 完成状態イメージ

| サービス | ポート | 備考 |
|:--|:--|:--|
| APIサーバ (Rails) | http://localhost:3000 | Rails標準ポート |
| DBサーバ (PostgreSQL) | localhost:5432 | ユーザ名/パスワード postgres/password |
