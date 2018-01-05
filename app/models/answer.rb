class Answer < ApplicationRecord
    validates_presence_of :text, :question, :user

    belongs_to :question
    belongs_to :user

    has_many :votes, as: :voteable
    has_many :comments, as: :commentable
    has_many :revisions, as: :revisable
end
