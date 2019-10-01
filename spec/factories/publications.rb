FactoryBot.define do
  factory :publication, class: Publication do
    title { '春淡し' }
    author { '佐伯泰英' }
    image { 'https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/8576/9784334778576.jpg' }
    isbn_code { '9784334778576' }
  end
end
