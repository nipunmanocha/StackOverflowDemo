class Vote < ApplicationRecord
    validates_presence_of :value, :voteable_id, :voteable_type, :user_id
    validates_numericality_of :value, :voteable_id, :user_id

    belongs_to :voteable, polymorphic: true
    belongs_to :user
end
