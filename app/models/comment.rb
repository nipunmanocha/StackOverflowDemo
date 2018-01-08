class Comment < ApplicationRecord
    validates_presence_of :text, :commentable, :user

    belongs_to :user
    belongs_to :commentable, polymorphic: true

    default_scope { where(deleted_at: nil) }
end
