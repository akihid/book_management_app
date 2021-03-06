require 'rails_helper'

describe '感想CRUD機能' , type: :system do
  let(:user_a) {FactoryBot.create(:user , name: 'ユーザーA' , email: 'a@co.jp')}
  let(:user_b) {FactoryBot.create(:user , name: 'ユーザーB' , email: 'b@co.jp')}
  let(:user_c) {FactoryBot.create(:user , name: 'ユーザーC' , email: 'c@co.jp')}

  3.times do| num| 
    let!("publication_#{num}") { FactoryBot.create(:publication, title: "出版物#{num}", isbn_code: "123456789000#{num}", price: 800) }
  end

  let!(:book_0) { FactoryBot.create(:book, user: user_a, publication: publication_0, read_status: 0) }
  let!(:book_1) { FactoryBot.create(:book, user: user_a, publication: publication_1, read_status: 0) }
  let!(:book_2) { FactoryBot.create(:book, user: user_a, publication: publication_2, read_status: 2) }
  let!(:book_b) { FactoryBot.create(:book, user: user_b, publication: publication_0) }
  let!(:post_b) { FactoryBot.create(:post, book: book_b) }

  before do
    visit user_session_path
    fill_in 'メールアドレス' , with: login_user.email
    fill_in 'パスワード' , with: login_user.password
    click_on 'Log in'
  end

  describe 'ユーザーページの金額表示確認' do
    let(:login_user) {user_a}

    it '読んだ本の金額' do
      visit user_path(user_a.id)
      within '.finish_price' do
        expect(page).to have_content '800'
      end
    end

    it '読んでいない本の金額' do
      visit user_path(user_a.id)
      within '.not_read_price' do
        expect(page).to have_content '1,600'
      end   
    end
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

  describe 'ユーザーページのいいね表示確認' do
    let(:login_user) {user_a}

    it 'いいねがある場合' do
      Good.create(post_id: post_b.id, user_id: user_c.id)
      visit user_path(user_c.id)
      page.first("#good-tab").click
      expect(page).to have_content 'postのテストタイトル'
    end

    it 'いいねがない場合' do
      Good.create(post_id: post_b.id, user_id: user_c.id)
      visit user_path(user_b.id)
      page.first("#good-tab").click
      expect(page).not_to have_content 'postのテストタイトル'
    end
  end

  describe 'ユーザーページのコメント表示確認' do
    let(:login_user) {user_a}

    it 'コメントがある場合' do
      Comment.create(post_id: post_b.id, user_id: user_c.id, content: "コメントのテストです")
      visit user_path(user_c.id)
      page.first("#comment-tab").click
      expect(page).to have_content 'postのテストタイトル'
    end

    it 'コメントがない場合' do
      Comment.create(post_id: post_b.id, user_id: user_c.id, content: "コメントのテストです")
      visit user_path(user_b.id)
      page.first("#comment-tab").click
      expect(page).not_to have_content 'postのテストタイトル'
    end
  end

  describe 'ユーザーページの持っている本表示確認' do
    let(:login_user) {user_b}

    it 'マイページの場合、持っている本の編集リンクが存在する' do
      visit user_path(user_b.id)
      expect(page).to have_selector '#book-tab'
      page.first("#book-tab").click
      expect(page).to have_content '出版物0'
      expect(page).to have_content '編集'
    end

    it 'マイページでない場合、持っている本の編集リンクが存在しない' do
      visit user_path(user_a.id)
      expect(page).to have_selector '#book-tab'
      page.first("#book-tab").click
      expect(page).to have_content '出版物0'
      expect(page).not_to have_content '編集'
    end
  end
end

