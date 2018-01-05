class Comment < ApplicationRecord
    validates_presence_of :text, :commentable_id, :commentable_type, :user_id
    validates_numericality_of :commentable_id, :user_id

    belongs_to :user

    belongs_to :commentable, polymorphic: true
end
