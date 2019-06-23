FactoryBot.define do
  factory :book do
    user { User.first || create(:user) }
    publication
  end
end
