
# VSCode DevContainer セットアップ手順

## 前提条件
- VSCodeがインストール済み
- `Remote - Containers` 拡張機能を導入済み
- DevContainerの設定ファイル (`.devcontainer/devcontainer.json`) がプロジェクトに配置済み

---

## 手順

### 1. ワークスペースを開く

作成済みの `fighters-record.code-workspace` をVSCodeで開きます。

### 2. DevContainerを起動

以下のいずれかの方法でDevContainerを開けます。

**方法A（推奨）：コマンドパレット利用**

1. VSCodeで `Cmd+Shift+P`（Mac）または `Ctrl+Shift+P`（Windows）を押します。
2. コマンドパレットで以下を選択します。

```
Remote-Containers: Reopen Folder in Container
```

**方法B：GUIアイコン利用**

1. VSCodeの左下の青いステータスバーにある `><` アイコンをクリックします。
2. 表示されるメニューから以下を選択します。

```
Reopen Folder in Container
```

### 3. コンテナの起動確認

- 初回起動時はコンテナのビルドで少し時間がかかります。
- 起動完了後、ステータスバーに以下のように表示されます。

```
Dev Container: fighters-record-api-dev
```

### 4. コンテナ内の確認作業

VSCode内のターミナルを開き、以下のコマンドで動作確認をします。

```bash
ruby -v
rails -v
bundle check
```

### 5. Gemのインストール

```bash
bundle install
```

### 6. DB初期化

```bash
rails db:create db:migrate
```

### 7. サーバの状態確認

Docker起動時にRailsサーバが既に起動しているため、以下のURLで動作確認できます。
http://localhost:3000


ターミナルで状態を確認したい場合は以下を実行します。

```bash
docker compose logs api
```

これでDevContainerの環境が整い、開発が可能となります。


これでDevContainerの環境が整い、開発が可能となります。
