require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'commentモデルテスト' do
    describe 'commen†新規作成' do
      context '成功' do
        it 'contentが存在すればOK' do
          comment = FactoryBot.create(:comment)
          expect(comment).to be_valid
        end
      end

      context '失敗' do
        it 'contentが空だとバリデーションエラー' do
          comment = FactoryBot.build(:comment, content: '')
          expect(comment).not_to be_valid
        end

      end
    end
  end
end
