class Revision < ApplicationRecord
    validates_presence_of :revisable

    belongs_to :revisable, polymorphic: true

    default_scope { where(deleted_at: nil) }
end
