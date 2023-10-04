class User < ApplicationRecord
    has_many :tasks

    validates :name, presence: true, length: { maximum: 255 }
    validates :email, presence: true, uniqueness: true, length: { maximum: 255 }
    has_secure_password

    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
end
