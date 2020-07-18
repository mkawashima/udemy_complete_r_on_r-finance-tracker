# README

## Docker Rails環境
Docker Composeを使用してRails6 / PostgreSQL のアプリケーション環境を構築する。

### 前提

* DBは、PostgreSQL。
* gemは、(ゲストOSの)globalにインストールされる。


## 環境構築手順

### rails new

rails new を実行し、インストール。
```
$ docker-compose run web rails new . --force --no-deps --database=postgresql
```

### docker image ビルド

ここまでのコンテナを永続化。
```
$ docker-compose build
```

### データーベースの設定

データーベース接続情報を定義する。

config/database.yml
```
default: &default
  adapter: postgresql
  encoding: unicode
  host: db
  username: postgres
  password: password
  pool: 5

development:
  <<: *default
  database: myapp_development

test:
  <<: *default
  database: myapp_test
```

データーベースを作成する。
```
$ docker-compose run web rake db:create
```

### 起動

```
$ docker-compose up
```

## 環境 起動/停止 など

### 起動

```
$ docker-compose up
```
サーバー Pumaも起動される。

`http://localhost:3000` でアクセス可能。

### 停止
`Ctrl-C` で、Puma停止

コンテナ停止
```
$ docker-compose down
```

### コマンドライン、shell

コンテナ名を確認後、シェル起動
```
$ docker ps  # コンテナ名を確認
$ docker exec -it [コンテナ名] /bin/bash
```





