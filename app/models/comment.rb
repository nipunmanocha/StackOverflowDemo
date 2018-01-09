class Comment < ApplicationRecord
    validates_presence_of :text, :commentable, :user

    belongs_to :user
    belongs_to :commentable, polymorphic: true

    preserve_data
end
