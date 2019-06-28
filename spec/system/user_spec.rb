require 'rails_helper'

describe '感想CRUD機能' , type: :system do
  let(:user_a) {FactoryBot.create(:user , name: 'ユーザーA' , email: 'a@co.jp')}
  let(:user_b) {FactoryBot.create(:user , name: 'ユーザーB' , email: 'b@co.jp')}
  let(:user_c) {FactoryBot.create(:user , name: 'ユーザーC' , email: 'c@co.jp')}

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

  describe 'ユーザーページの感想表示確認' do
    let(:login_user) {user_a}

    before do 
      visit user_path(user_b.id)
    end

    it 'ユーザーページに投稿した感想が表示されている' do
      expect(page).to have_content 'postのテストタイトル'
    end

    it '感想がなければユーザーページに表示されない' do
      visit user_path(user_c.id)
      expect(page).not_to have_content 'postのテストタイトル'
    end
  end
end

