class Vote < ApplicationRecord
    validates_presence_of :value, :voteable, :user

    belongs_to :voteable, polymorphic: true
    belongs_to :user

    default_scope { where(deleted_at: nil) }
end
