class Answer < ApplicationRecord
    validates_presence_of :text, :question_id, :user_id
    validates_numericality_of :question_id, :user_id

    belongs_to :question
    belongs_to :user

    has_many :votes, as: :voteable
end
