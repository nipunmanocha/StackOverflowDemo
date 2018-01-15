class Question < ApplicationRecord
    commentable
    preserve_data
    revisable
    voteable

    validates_presence_of :text, :user

    belongs_to :user
    
    has_many :answers
    
    has_and_belongs_to_many :tags
end
