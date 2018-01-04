class User < ApplicationRecord
    validates :name, presence: true, length: {minimum:1, maximum:100}
    validates :email, presence: true, length: {minimum:1, maximum:100}, uniqueness: true
    validates :password, presence: true
    validates :salt, presence: true, uniqueness: true
end