# matcha
## ゴール
42Parisのセカンドサークルの課題matchaに取り組みました。
マッチングアプリを作成する課題になります。
利用する技術は、自分で決められるので、今回は下記を利用しました。
- プロキシサーバー: nginx
- フロントエンド: Next.js(React)
- バックエンド: Express(Node.js)
- DB: mariadb

## やってみた結果


## 開発環境
- macOS
- VidualStudioCode

## 事前準備
- nodeとnpmがインストール済みで有ることを確認しました。
```
% node -v
v18.17.0
% npm -v
9.6.7
```

## やったこと
- クライアント側のプロジェクト作成
- サーバー側のプロジェクト作成
- Dockerコンテナ化する
- DBの追加
- プロキシサーバーの追加
- プロキシサーバー → クライアント側 → サーバー側 → DBの接続確立
- ユーザー認証機能の作成
- ユーザー情報表示機能の作成

## クライアント側のプロジェクト作成
Next.js(React)のプロジェクトを作成しました。
```
% npx create-next-app@latest
✔ What is your project named? … client
✔ Would you like to use TypeScript? … Yes
✔ Would you like to use ESLint? … Yes
✔ Would you like to use Tailwind CSS? … Yes
✔ Would you like to use `src/` directory? … Yes
✔ Would you like to use App Router? (recommended) … Yes
✔ Would you like to customize the default import alias (@/*)? … No
```

## サーバー側のプロジェクト作成
Express(Node.js)のプロジェクトを作成しました。
package.jsonに追記して、修正時に即座にコンパイルされるように、開発モードの起動方法を指定しました。
また、アプリ起動時に走るindex.jsで、Expressアプリを起動するよう記載しました。
```
% mkdir server
% cd server
% npm init
package name: (matcha_re) server
version: (1.0.0) 
description: 
entry point: (index.js) 
test command: 
git repository: 
keywords: 
author: 
license: (ISC) 
% npm i express
% npm i nodemon --save-dev
% vi package.json
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "start": "node index.js",
    "dev": "nodemon index.js"
  },
% vi index.js
const express = require('express');
const app = express();
const PORT = 4000;

app.get('/api/hello', (req, res) => {
    res.json({ message: 'Hello World!' });
})

app.listen(PORT, () => {
    console.log(`Server listening at http://localhost:${PORT}`);
})
```

## Dockerコンテナ化する
アプリを起動する為のDockerfileを[client側](https://github.com/Lala-pukuchan/matcha/blob/main/client/Dockerfile)、[server](https://github.com/Lala-pukuchan/matcha/blob/main/server/Dockerfile)側それぞれに作成しました。
ルートディレクトリのdocker-compose.ymlから、それらを使ってイメージを作成するように指定しました。
```
docker compose up --build
```
[クライアント側](http://localhost:3000/)に接続すると、画面の表示が確認できました。
![クライアント側の表示](./img/client.png)
[サーバー側](http://localhost:4000/)に接続すると、jsonデータの表示が確認できました。
![サーバー側の表示](./img/server.png)

## DBの追加
docker-compose.ymlを修正して、mariadbを追加しました。
また、phpMyAdminを追加して、DBの内容をブラウザから確認できるようにしました。

## プロキシサーバーの追加
docker-compose.ymlを修正して、nginxを追加しました。

## プロキシサーバー → クライアント側 → サーバー側 → DBの接続確立

## ユーザー認証機能の作成
## ユーザー情報表示機能の作成