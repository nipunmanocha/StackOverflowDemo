class Answer < ApplicationRecord
    commentable
    preserve_data
    revisable
    voteable

    validates_presence_of :text, :question, :user

    belongs_to :question
    belongs_to :user
end
