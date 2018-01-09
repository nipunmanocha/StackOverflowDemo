class Answer < ApplicationRecord
    include SoftDelete
    include Commentable
    include Voteable
    include Revisable

    validates_presence_of :text, :question, :user

    belongs_to :question
    belongs_to :user
end
