class Vote < ApplicationRecord
    preserve_data

    validates_presence_of :value, :voteable, :user

    belongs_to :voteable, polymorphic: true
    belongs_to :user
end
