require 'rails_helper'

describe '本CRUD機能' , type: :system do
  let(:user_a) {FactoryBot.create(:user , name: 'ユーザーA' , email: 'a@co.jp')}
  # let(:user_b) {FactoryBot.create(:user , name: 'ユーザーB' , email: 'b@co.jp')}
  # let!(:publication_a) { FactoryBot.create(:publication, title: '出版物1', isbn_code: '1234567890001') }
  # let!(:publication_b) { FactoryBot.create(:publication, title: '出版物2', isbn_code: '1234567890002') }
  # let!(:publication_c) { FactoryBot.create(:publication, title: '出版物3', isbn_code: '1234567890003') }
  # let!(:book_a) { FactoryBot.create(:book)}

  before do
    visit user_session_path
    fill_in 'Email' , with: login_user.email
    fill_in 'Password' , with: login_user.password
    click_button 'Log in'
  end

  describe '新規作成機能' do
    let(:login_user) {user_a}

    before do 
      visit publications_path
      fill_in 'title' , with: '漫画'
      click_button '検索'
      page.first("#img_btn").click
      page.driver.browser.switch_to.alert.accept
    end

    context '新規作成画面でカテゴリを入力' do

      it '正常に登録される' do
        (all(".ui-widget-content")[1]).set("漫画")
        click_button '登録'
        expect(page).to have_selector '.alert-success' , text: '登録完了'
        expect(page).to have_selector '.tag'
      end
    end

    context '新規作成画面でカテゴリを未入力' do

      it '正常に登録される' do
        click_button '登録'
        expect(page).to have_selector '.alert-success' , text: '登録完了'
        expect(page).not_to have_selector '.tag'
      end
    end
  end
end

