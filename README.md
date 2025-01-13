# README
## プロジェクト名
家計簿アプリ

## 要件定義書
https://docs.google.com/spreadsheets/d/1rlNiBS8v7k8ah4fHNj1zGBNZ_PMaRFpsryAfmxVuA7w/edit?gid=1715608027#gid=1715608027

## 概要
一般家庭で利用するような収支を記録し、分析する家計簿アプリを作成する。

## 技術スタック
- 言語：フロントエンドTypeScript、バックエンドRuby
- フレームワーク：フロントエンドNext.js、バックエンドRuby on Rails
- DB：MySQL
- クラウド：AWS（S3）
- コンテナ：Docker
- CI/CD：Github Actions
- 開発環境：Mac、VSCode
- その他：Github Copilot

## 機能
- 収支の金額、日付、カテゴリ、内容を登録する
- 登録した収支のデータを削除する。
- 登録した収支のデータを一覧で表示する。
- 登録した収支のデータをグラフで表示する。

（実装予定）
- 収支ごとに画像を登録する。
- 目標貯蓄額を登録する。
- AIから目標貯蓄額の達成のためのレコメンドをもら
う。
