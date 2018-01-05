class Question < ApplicationRecord
    validates_presence_of :text, :user

    belongs_to :user
    
    has_many :answers
    has_many :votes, as: :voteable
    has_many :comments, as: :commentable

    has_and_belongs_to_many :tags
end
