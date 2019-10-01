require 'rails_helper'

RSpec.describe Book, type: :model do

  describe "postモデルテスト" do
    
    describe "post新規作成" do

      context "成功" do
        it "title, contentが存在すればOK" do
          post = FactoryBot.create(:post)
          expect(post).to be_valid
        end
      end

      context "失敗" do

        it 'titleが空だとバリデーションエラー' do
          post = FactoryBot.build(:post, title: '')
          expect(post).not_to be_valid
        end

        it 'titleが20文字以上だとバリデーションエラー' do
          post = FactoryBot.build(:post, title: 'a' * 21)
          expect(post).not_to be_valid
        end

        it 'contentが空だとバリデーションエラー' do
          post = FactoryBot.build(:post, content: '')
          expect(post).not_to be_valid
        end

        it 'contentが200文字以上だとバリデーションエラー' do
          post = FactoryBot.build(:post, content: 'a' * 201)
          expect(post).not_to be_valid
        end
      end
    end
  end
end