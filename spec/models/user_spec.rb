require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'userモデルテスト' do
    
    describe 'user新規作成' do

      context '成功' do
        it 'name, email, passwordが存在すればOK' do
          user = User.new(
            name: '田中太郎',
            email: 'tanaka@co.jp',
            password: '123456'
            )
          expect(user).to be_valid
        end
      end

      context '失敗' do

        it 'emailが空だとバリデーションエラー' do
          user = FactoryBot.build(:user, email: '')
          user.valid?
          expect(user.errors.messages[:email]).to include("を入力してください")
        end

        it 'passwordが空だとバリデーションエラー' do
          user = FactoryBot.build(:user, password: '')
          user.valid?
          expect(user.errors.messages[:password]).to include("を入力してください")
        end

        it 'password_confirmationが空だとバリデーションエラー' do
          user = FactoryBot.build(:user, password_confirmation: '')
          user.valid?
          expect(user.errors.messages[:password_confirmation]).to include("とパスワードの入力が一致しません")
        end

      end

    end
  end
end