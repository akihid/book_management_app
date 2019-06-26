class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  mount_uploader :icon, IconUploader

  has_many :books, dependent: :destroy
  has_many :publications, through: :books
  has_many :comments, dependent: :destroy
  has_many :goods, dependent: :destroy
  has_many :posts, through: :goods

  validates :name, presence: true, length: { maximum: 10 }
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }

  def update_with_password(params, * options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params, * options)
  end
end
