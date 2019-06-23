require 'rails_helper'

RSpec.describe Book, type: :model do

  describe "bookモデルテスト" do
    
    describe "book新規作成" do

      context "成功" do
        it "user_id, publication_idが存在すればOK" do
          book = FactoryBot.create(:book)
          expect(book).to be_valid
        end
      end

      context "失敗" do

        it 'user_idが空だとバリデーションエラー' do
          book = FactoryBot.build(:book, user_id: '')
          expect(book).not_to be_valid
        end

        it 'publication_idが空だとバリデーションエラー' do
          book = FactoryBot.build(:book, publication_id: '')
          expect(book).not_to be_valid
        end
      end
    end
  end
end