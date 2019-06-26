require 'rails_helper'

describe '出版物検索機能' , type: :system do
  let(:user_a) {FactoryBot.create(:user , name: 'ユーザーA' , email: 'a@co.jp')}

  before do
    visit user_session_path
    fill_in 'メールアドレス' , with: login_user.email
    fill_in 'パスワード' , with: login_user.password
    click_on 'Log in'
  end

  describe '出版物検索機能' do
    let(:login_user) {user_a}

    before do 
      visit publications_path
    end

    it '文字を入力せずに検索すると、表示される' do
      click_on '検索'
      expect(page).to have_selector '.page-item'
    end

    it '１文字だけ入力して検索すると、エラーメッセージが表示される' do
      fill_in 'title' , with: 'a'
      click_on '検索'
      expect(page).to have_content '検索文字列には2文字以上、60文字以下を使用してください'
    end

    it '2文字入力して、検索するとエラーメッセージが表示されない' do
      fill_in 'title' , with: '漫画'
      click_on '検索'
      expect(page).not_to have_content '検索文字列には2文字以上、60文字以下を使用してください'
    end

    it '128文字以上入力して、検索するとエラーメッセージが表示される' do
      fill_in 'title' , with: 'a' * 61
      click_on '検索'
      expect(page).to have_content '検索文字列には2文字以上、60文字以下を使用してください'
    end

    it '128文字入力して、検索するとエラーメッセージが表示されない' do
      fill_in 'title' , with: 'a' * 60
      click_on '検索'
      expect(page).not_to have_content '検索文字列には2文字以上、128文字以下を使用してください'
    end

    it '検索結果がない場合、メッセージが表示される' do
      fill_in 'title' , with: 'a' * 60
      click_on '検索'
      expect(page).to have_content '検索結果がありませんでした'
    end
  end

end

