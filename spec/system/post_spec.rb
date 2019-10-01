require 'rails_helper'

describe '感想CRUD機能' , type: :system do
  let(:user_a) {FactoryBot.create(:user , name: 'ユーザーA' , email: 'a@co.jp')}
  let(:user_b) {FactoryBot.create(:user , name: 'ユーザーB' , email: 'b@co.jp')}

  3.times do| num| 
    let!("publication_#{num}") { FactoryBot.create(:publication, title: "出版物#{num}", isbn_code: "123456789000#{num}") }
  end

  let!(:book_0) { FactoryBot.create(:book, user: user_a, publication: publication_0) }
  let!(:book_1) { FactoryBot.create(:book, user: user_a, publication: publication_1) }
  let!(:book_2) { FactoryBot.create(:book, user: user_a, publication: publication_2) }
  let!(:book_b) { FactoryBot.create(:book, user: user_b, publication: publication_0) }
  let!(:post_b) { FactoryBot.create(:post, book: book_b) }

  before do
    visit user_session_path
    fill_in 'メールアドレス' , with: login_user.email
    fill_in 'パスワード' , with: login_user.password
    click_on 'Log in'
  end

  describe '新規作成機能' do
    let(:login_user) {user_a}

    before do 
      visit new_post_path
    end

    it '登録ボタン押下後、確認画面が表示される' do
      fill_in 'タイトル' , with: '感想のタイトルです'
      fill_in '内容' , with: '感想の詳細です'
      click_on '登録'
      expect(page).to have_content '感想の詳細です'
    end

    it '確認画面で登録後一覧画面に表示される' do
      fill_in 'タイトル' , with: '感想のタイトルです'
      fill_in '内容' , with: '感想の詳細です'
      click_on '登録'
      click_on '登録'
      expect(page).to have_content '感想のタイトルです'
    end
    it '確認画面から戻った際に入力情報が保持される' do
      fill_in 'タイトル' , with: '感想のタイトル確認です'
      fill_in '内容' , with: '感想の詳細確認です'
      select '出版物2', from: 'post[publication_id]'
      click_on '登録'
      click_on '修正する'
      expect(page).to have_content '感想の詳細確認です'
      expect(page).to have_content '出版物2'
    end
  end

  describe '編集機能' do
    let(:login_user) {user_a}

    before do 
      visit new_post_path
      fill_in 'タイトル' , with: '感想のタイトルです'
      fill_in '内容' , with: '感想の詳細です'
      click_on '登録'
      click_on '登録'
      page.first('#edit_post').click
    end

    it '編集後、一覧画面に更新された内容が表示される' do
      fill_in 'タイトル' , with: '感想のタイトル更新です'
      fill_in '内容' , with: '感想の詳細更新です'
      click_on '登録'
      expect(page).to have_content '感想のタイトル更新です'
    end
  end

  describe '削除機能' do
    let(:login_user) {user_a}

    before do 
      visit new_post_path
      fill_in 'タイトル' , with: '感想のタイトルです'
      fill_in '内容' , with: '感想の詳細です'
      click_on '登録'
      click_on '登録'
      page.first('#delete_post').click
    end

    it 'アラートでOK押下時、削除される' do
      page.driver.browser.switch_to.alert.accept
      expect(page).not_to have_content '感想のタイトルです'
    end
    it 'アラートでキャンセル押下時、削除されない' do
      page.driver.browser.switch_to.alert.dismiss
      expect(page).to have_content '感想のタイトルです'
    end
  end

  describe '一覧の表示確認' do
    let(:login_user) {user_a}

    before do 
      visit posts_path
    end

    it '異なるユーザーが投稿した感想の編集ボタンは表示されない' do
      expect(page).to have_content 'ユーザーB'
      expect(page).not_to have_content '編集'
    end

    it '異なるユーザーが投稿した感想の削除ボタンは表示されない' do
      expect(page).to have_content 'ユーザーB'
      expect(page).not_to have_content '削除'
    end
  end

  describe 'コメント新規作成' do
    let(:login_user) {user_a}
    
    before do 
      visit post_path(post_b)
    end

    it 'コメント成功' do
      fill_in 'comment[content]' , with: 'コメントのテストです'
      click_on '送信'
      expect(page).to have_content 'ユーザーA'
      expect(page).to have_content 'コメントのテストです'
    end

    it 'コメント失敗' do
      fill_in 'comment[content]' , with: ''
      click_on '送信'
      expect(page).not_to have_content 'ユーザーA'
    end
  end

  describe 'コメント表示テスト' do
    let(:login_user) {user_a}
    
    before do 
      visit post_path(post_b)
      fill_in 'comment[content]' , with: 'コメントのテストです'
      click_on '送信'
      visit posts_path
    end

    it '最新のコメント表示されている' do
      expect(page).to have_content 'コメントのテストです'
    end

  end

  describe 'いいね機能' do
    let(:login_user) {user_a}
    
    before do 
      visit post_path(post_b)
    end

    it 'いいね設定' do
      page.first(".like-btn").click
      expect(page).to have_content '1'
      expect(page).to have_selector '.like-btn-unlike'
    end

    it 'いいね解除' do
      page.first(".like-btn").click
      page.first(".like-btn-unlike").click
      expect(page).to have_content '0'
      expect(page).to have_selector '.like-btn'
    end
  end
end

