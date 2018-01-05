class User < ApplicationRecord
    validates_presence_of :name, :email
    validates_uniqueness_of :email

    has_many :questions
    has_many :answers
    has_many :votes
end