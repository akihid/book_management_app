FactoryBot.define do
  factory :post do
    title { 'postのテストタイトル'}
    content { 'postのテスト内容'}
    book { Book.first || create(:book)}
  end
end