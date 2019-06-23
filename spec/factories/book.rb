FactoryBot.define do
  factory :book do
    user { User.first || create(:user)}
    publication { Publication.first || create(:publication)}
  end
end