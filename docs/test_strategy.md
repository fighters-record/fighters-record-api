# テスト戦略

## 🎯 目的

本プロジェクトのテストは、以下の3層構成で「粒度と目的」を明確に分離し、保守性とスピードの両立を目指します。

---

## 🧪 テスト分類と目的

| 種別             | 目的                               | 実行方法                       |
|------------------|------------------------------------|--------------------------------|
| ユニットテスト    | モデルやサービスの単体ロジック検証 | `make rspec` または `make t/...` |
| リクエストテスト | API単体の入力と出力の整合性検証   | `make rspec` または `make t/...` |
| シナリオテスト    | 実際にAPIサーバを叩く統合動作確認 | `make rspec-scenario` または `make t:scenario/...` |

---

## 🚧 シナリオテストについて

- `spec/scenario/` 配下に配置
- 通常のRSpec実行では除外される（`.rspec` の `--tag ~scenario` 指定による）
- 実行には API サーバの起動が必要（Cloud Run や `rails s` など）

### ✅ 実行例

```bash
# 全体実行
make rspec-scenario

# 個別実行
make t:scenario/scenario/api_login_flow_spec.rb
```

---

## ⚙ Makefileによる補助

以下のようなMakeターゲットを用意しています：

| ターゲット                     | 説明                           |
|-------------------------------|--------------------------------|
| `make rspec`                  | ユニット＋リクエストテスト一括実行 |
| `make t/...`                  | 任意ファイルのテスト（ユニット/リクエスト） |
| `make rspec-scenario`         | シナリオテスト全体実行        |
| `make t:scenario/...`         | シナリオテストのファイル単体実行 |

---

## 🔒 注意点

- シナリオテストは `API_HOST` を明示的に指定する必要があります（Makefileで自動化済）
- test環境では `config.hosts` に `www.example.com`, `localhost` を追加済

---

## 📌 今後の拡張方針（任意）

- `FactoryBot.build_stubbed` の活用によるユニットテスト高速化
- `parallel_tests` による並列化（テスト数増加時）
- E2Eテスト（例：Playwright）導入の検討（フロント統合後）