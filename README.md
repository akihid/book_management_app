# README

# 書籍管理アプリ

## 概要
自分の購入した書物を管理することができるサービス。
本を読んだ感想もできます。

## コンセプト
自分が持っている本を管理かつ、読んだ感想を共有することで新しい本と出会うきっかけを作る。

## バージョン
Ruby 2.5.3
Rails 5.2.3

## 機能一覧
- [ ] ログイン機能
- [ ] ユーザー登録機能
  - [ ] メールアドレス、名前、パスワードは必須
- [ ] 書籍登録機能
  - [ ] ユーザーはタイトルの一部を入力するのみ
  - [ ] 書籍選択機能
   - [ ] APIから取得した情報をもとに書籍イメージとタイトルを一覧表示ユーザーに選択された書籍を登録する
- [ ] 書籍検索機能
  - [ ] 登録済みの書籍をタイトル名、カテゴリで検索できる
- [ ] 感想一覧表示機能
  - [ ] 最新のコメントを表示
- [ ] 感想投稿機能
  - [ ] タイトルと内容は必須
- [ ] 感想編集機能
- [ ] 感想削除機能
  - [ ] 編集と削除は投稿者のみ実行可能
- [ ] 感想いいね機能
  - [ ] いいねについては1つの感想に対して1人1回しかできない
- [ ] コメント投稿機能
- [ ] コメント削除機能
  - [ ] コメント削除はコメントした本人のみ可能
- [ ] コメント機能といいね機能についてはページ遷移なしで実行できる


## カタログ設計
https://docs.google.com/spreadsheets/d/1gdeDxyxdIf_U3A0NWRtomIqHprqu-0Awi_F2DwC_BwI

## テーブル定義
https://docs.google.com/spreadsheets/d/1gdeDxyxdIf_U3A0NWRtomIqHprqu-0Awi_F2DwC_BwI/view#gid=96870717

## ER図
https://docs.google.com/spreadsheets/d/1gdeDxyxdIf_U3A0NWRtomIqHprqu-0Awi_F2DwC_BwI/view#gid=1999157521

## 画面遷移図
https://docs.google.com/spreadsheets/d/1gdeDxyxdIf_U3A0NWRtomIqHprqu-0Awi_F2DwC_BwI/view#gid=722538482

## 画面ワイヤーフレーム
https://docs.google.com/spreadsheets/d/1GunDeUpsYFrHrl7eVSnY0QFHW2LYBnhZ-TkU5CQSVVo/view?usp=sharing

## 使用予定Gem
* acts-as-taggable-on
* bootstrap
* carrierwave
* devise
* dotenv-rails
* jquery-rails
* jquery-ui-rails
* rakuten_web_service