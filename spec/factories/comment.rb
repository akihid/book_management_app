FactoryBot.define do
  factory :comment do
    user { User.first || create(:user) }
    post
    content { 'commentのテスト' }
  end
end
