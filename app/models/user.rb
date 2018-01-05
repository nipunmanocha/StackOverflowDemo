class User < ApplicationRecord
    validates :name, presence: true, length: {minimum:1, maximum:100}
    validates :email, presence: true, length: {minimum:1, maximum:100}, uniqueness: true
    validates :password, presence: true, length: {minimum:1, maximum:100}
    validates :salt, presence: true, length: {minimum:1, maximum:100}, uniqueness: true

    has_many :questions
end