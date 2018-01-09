class Answer < ApplicationRecord
    validates_presence_of :text, :question, :user

    belongs_to :question
    belongs_to :user

    preserve_data
    commentable
    voteable
    revisable
end
