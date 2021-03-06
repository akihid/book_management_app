require 'rails_helper'

describe '本CRUD機能' , type: :system do
  let(:user_a) {FactoryBot.create(:user , name: 'ユーザーA' , email: 'a@co.jp')}

  before do
    visit user_session_path
    fill_in 'メールアドレス' , with: login_user.email
    fill_in 'パスワード' , with: login_user.password
    click_on 'Log in'
  end

  describe '新規作成機能' do
    let(:login_user) {user_a}

    before do 
      visit publications_path
      fill_in 'title' , with: '漫画'
      click_on '検索'
      page.first('#img_btn').click
      page.driver.browser.switch_to.alert.accept
    end

    context '新規作成画面でカテゴリを入力' do

      it 'カテゴリありで登録される' do
        (all('.ui-widget-content')[1]).set('漫画')
        click_on '登録'
        expect(page).to have_selector '.alert-success' , text: '登録完了'
        page.first("#book-tab").click
        expect(page).to have_selector '.tag'
      end
    end

    context '新規作成画面でカテゴリを未入力' do

      it 'カテゴリなしで登録される' do
        click_on '登録'
        expect(page).to have_selector '.alert-success' , text: '登録完了'
        page.first("#book-tab").click
        expect(page).not_to have_selector '.tag'
      end
    end

    context '新規作成画面で状態を入力' do

      it '未読が選択されている' do
        expect(page).to have_checked_field '未読'
      end
      
      it '未読で登録される' do
        find('.not_read').click
        click_on '登録'
        expect(page).to have_selector '.alert-success' , text: '登録完了'
        page.first("#book-tab").click
        within '.read_status' do
          expect(page).to have_content '未読'
        end  
      end

      it '読書中で登録される' do
        find('.now_read').click
        click_on '登録'
        expect(page).to have_selector '.alert-success' , text: '登録完了'
        page.first("#book-tab").click
        within '.read_status' do
          expect(page).to have_content '読書中'
        end
      end

      it '読了で登録される' do
        find('.finish_read').click
        click_on '登録'
        expect(page).to have_selector '.alert-success' , text: '登録完了'
        page.first("#book-tab").click
        within '.read_status' do
          expect(page).to have_content '読了'
        end
      end
    end
  end

  describe '編集機能' do
    let(:login_user) {user_a}

    before do 
      visit publications_path
      fill_in 'title' , with: '漫画'
      click_on '検索'
      page.first('#img_btn').click
      page.driver.browser.switch_to.alert.accept
      (all('.ui-widget-content')[1]).set('漫画')
      find('.finish_read').click
      click_on '登録'
      page.first("#book-tab").click
      page.first("#edit_book").click
    end

    context '編集画面でカテゴリを追加' do
      it 'カテゴリが追加され更新される' do
        (all('.ui-widget-content')[2]).set('漫画2')
        click_on '登録'
        click_on '登録'
        expect(page).to have_selector '.alert-success', text: '編集完了'
        page.first("#book-tab").click
        expect(page).to have_selector '.tag', text: '漫画2'
      end
    end

    context '編集画面でカテゴリを減らす' do
      it 'カテゴリなしで更新される' do
        # ×クリックでカテゴリが消える
        page.first('.text-icon').click
        click_on '登録'
        expect(page).to have_selector '.alert-success' , text: '編集完了'
        page.first("#book-tab").click
        page.first("#book-tab").click
        expect(page).not_to have_selector '.tag'
      end
    end

    context '編集画面で状態を更新' do

      it '読了が選択されている' do
        expect(page).to have_checked_field '読了'
      end

      it '未読に更新される' do
        find('.not_read').click
        click_on '登録'
        expect(page).to have_selector '.alert-success' , text: '編集完了'
        page.first("#book-tab").click
        within '.read_status' do
          expect(page).to have_content '未読'
        end  
      end

      it '読書中で更新される' do
        find('.now_read').click
        click_on '登録'
        expect(page).to have_selector '.alert-success' , text: '編集完了'
        page.first("#book-tab").click
        within '.read_status' do
          expect(page).to have_content '読書中'
        end
      end

    end
  end

  describe '削除機能' do
    let(:login_user) {user_a}

    before do 
      visit publications_path
      fill_in 'title' , with: '漫画'
      click_on '検索'
      page.first("#img_btn").click
      page.driver.browser.switch_to.alert.accept
      (all('.ui-widget-content')[1]).set('漫画')
      click_on '登録'
      page.first("#book-tab").click
      click_on '削除'
    end

    context '本を削除アラートでOK' do
      it '削除される' do
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_selector '.alert-danger', text: '削除完了'
      end
    end

    context '本を削除アラートでキャンセル' do
      it '削除されない' do
        page.driver.browser.switch_to.alert.dismiss
        expect(page).to have_selector '.tag', text: '漫画'
      end
    end
  end
end

