require 'rails_helper'

describe '感想CRUD機能' , type: :system do
  let(:user_a) {FactoryBot.create(:user , name: 'ユーザーA' , email: 'a@co.jp')}

  3.times do| num| 
    let!("publication_#{num}") { FactoryBot.create(:publication, title: "出版物#{num}", isbn_code: "123456789000#{num}") }
  end

  let!(:book_0) { FactoryBot.create(:book, user: user_a, publication: publication_0) }
  let!(:book_1) { FactoryBot.create(:book, user: user_a, publication: publication_1) }
  let!(:book_2) { FactoryBot.create(:book, user: user_a, publication: publication_2) }

  before do
    visit user_session_path
    fill_in 'Email' , with: login_user.email
    fill_in 'Password' , with: login_user.password
    click_on 'Log in'
  end

  describe '新規作成機能' do
    let(:login_user) {user_a}

    before do 
      visit new_post_path
    end

    it '登録ボタン押下後、確認画面が表示される' do
      fill_in 'post_title' , with: '感想のタイトルです'
      fill_in 'post_content' , with: '感想の詳細です'
      click_on '登録'
      expect(page).to have_content '感想の詳細です'
    end

    it '確認画面で登録後一覧画面に表示される' do
      fill_in 'post_title' , with: '感想のタイトルです'
      fill_in 'post_content' , with: '感想の詳細です'
      click_on '登録'
      click_on '登録'
      expect(page).to have_content '感想のタイトルです'
    end
    it '確認画面から戻った際に入力情報が保持される' do
      fill_in 'post_title' , with: '感想のタイトル確認です'
      fill_in 'post_content' , with: '感想の詳細確認です'
      select '出版物2', from: 'post[publication_id]'
      click_on '登録'
      click_on '修正する'
      expect(page).to have_content '感想の詳細確認です'
      expect(page).to have_content '出版物2'
    end
  end
end

