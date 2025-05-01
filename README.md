# README

### 🔍 シナリオテストについて

- `spec/scenario/` 配下に外部APIを対象とした結合テストを格納しています
- デフォルトでは実行されません（`.rspec` にて `--tag ~scenario` を指定）
- 実行するには以下のように `API_HOST` を指定してください：

```bash
make docker-rspec-scenario
