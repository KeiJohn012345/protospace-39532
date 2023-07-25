class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :email, :encrypted_password, :name, :profile, :occupation, :position, presence: true
  validates :email, uniqueness: true

  has_many :prototypes
  # has_many :comments, dependent: :destroy　現状だとユーザー削除の機能がないので要らない？？
end