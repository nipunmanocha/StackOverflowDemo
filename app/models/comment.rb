class Comment < ApplicationRecord
    include SoftDelete

    validates_presence_of :text, :commentable, :user

    belongs_to :user
    belongs_to :commentable, polymorphic: true
end
