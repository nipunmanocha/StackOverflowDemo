class Answer < ApplicationRecord
    include Commentable
    include Voteable
    include Revisable

    validates_presence_of :text, :question, :user

    belongs_to :question
    belongs_to :user
end
