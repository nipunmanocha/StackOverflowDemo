class Question < ApplicationRecord
    validates_presence_of :text, :user_id
    validates_numericality_of :user_id

    belongs_to :user
    has_many :answers

    has_many :votes, as: :voteable
    has_many :comments, as: :commentable
end
