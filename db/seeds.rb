# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 出版物作成
titles = [
  "プロを目指す人のためのRuby入門",
  "現場で使える Ruby on Rails 5速習実践ガイド",
  "ゼロからわかるRuby超入門",
  "独習Ruby on Rails",
  "メタプログラミングRuby第2版",
  "Vue．js入門",
  "Vue.jsのツボとコツがゼッタイにわかる本",
  "10年後の仕事図鑑",
  "日本進化論",
  "オブジェクト指向設計実践ガイド",
  "なぜ、あなたはJavaでオブジェクト指向開発ができないのか",
  "React.js & Next.js超入門",
  "リーダブルコード",
  "仕事ですぐ役立つVim＆Emacsエキスパート活用術",
  "Ruby　on　Rails超入門",
  "パーフェクトRuby　on　Rails",
  "痛快！コンピュータ学",
  "岩田剛典3rd写真集『タイトル未定』",
  "ノーサイド・ゲーム",
  "あり金は全部使え　貯めるバカほど貧しくなる",
  "公式ガイド＆レシピ　きのう何食べた？　〜シロさんの簡単レシピ〜",
]
authors = [
  "伊藤淳一（プログラミング）",
  "大場寧子/松本拓也",
  "五十嵐邦明/松岡浩平",
  "小餅 良介",
  "パオロ・ペロッタ/角征典",
  "川口和也/喜多啓介",
  "中田　亨",
  "堀江 貴文/落合 陽一",
  "落合 陽一",
  "サンディ・メッツ/高山泰基",
  "小森裕介/エスエムジー株式会社",
  "掌田津耶乃",
  "ダスティン・ボズウェル/トレバー・フォシェ",
  "伊藤淳一（プログラミング）",
  "竹馬力/山田祥寛",
  "すがわらまさのり/前島真一",
  "坂村健",
  "岩田 剛典/永瀬 正敏",
  "池井戸 潤",
  "堀江貴文",
  "講談社"
]

images = [
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/3977/9784774193977.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/2227/9784839962227.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/1237/9784297101237.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/0689/9784798160689.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/7430/9784873117430.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/0919/9784297100919.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/6494/9784798056494.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/4573/9784797394573.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/9868/9784797399868.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/3619/9784774183619.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/7741/77412222.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/6920/9784798056920.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/5658/9784873115658.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/0076/9784774180076.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/6183/9784774196183.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/5165/9784774165165.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/0874/08747428.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/0380/9784065170380.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/8376/9784478108376.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/0568/9784838730568.jpg",
  "https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/1327/9784065151327.jpg",
]

isbn_codes = [
  "9784774193977",
  "9784839962227",
  "9784297101237",
  "9784798160689",
  "9784873117430",
  "9784297100919",
  "9784798056494",
  "9784797394573",
  "9784797399868",
  "9784774183619",
  "9784774122229",
  "9784798056920",
  "9784873115658",
  "9784774180076",
  "9784774196183",
  "9784774165165",
  "9784087474282",
  "9784065170380",
  "9784478108376",
  "9784838730568",
  "9784065151327",
]

1.upto 20 do |num|
  name = Faker::Name.first_name
  email = "test#{num}@co.jp"
  password = "123456"
  password_confirmation = "123456"
  user = User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password_confirmation
  )

  title = titles[num]
  author = authors[num]
  image = images[num]
  isbn_code = isbn_codes[num]

  publication = Publication.create!(
    title: title,
    author: author,
    image: image,
    isbn_code: isbn_code
  )

  book = Book.create!(
    user_id: user.id,
    publication_id: publication.id
  )

  post = Post.create!(
    title: Faker::Lorem.word,
    content: Faker::Lorem.sentence,
    book_id: book.id
  )

  5.times do |j|
    Comment.create!(
      post_id: post.id,
      user_id: User.order("RANDOM()").first.id,
      content: Faker::Lorem.sentence
    )
  end
end

# 誰でも使える用のユーザーデータ
name = 'テストユーザー'
email = 'test@test.com'
password = "123456"
password_confirmation = "123456"
user = User.create!(
  name: name,
  email: email,
  password: password,
  password_confirmation: password_confirmation
)

1.upto 3 do |num|

  book = Book.create!(
    user_id: user.id,
    publication_id: num
  )

  post = Post.create!(
    title: Faker::Lorem.word,
    content: Faker::Lorem.sentence,
    book_id: book.id
  )

  Comment.create!(
    post_id: Post.order("RANDOM()").first.id,
    user_id: user.id,
    content: Faker::Lorem.sentence
  )

  Good.create!(
    post_id: Post.order("RANDOM()").first.id,
    user_id: user.id,
  )
end