require 'rails_helper'

RSpec.describe User, type: :model do

  describe "userモデルテスト" do
    
    describe "user新規作成" do

      context "成功" do
        it "name, email, passwordが存在すればOK" do
          user = User.new(
            name: "田中太郎",
            email: "tanaka@co.jp",
            password: "123456"
            )
          expect(user).to be_valid
        end
      end

    end
  end
end