class Vote < ApplicationRecord
    validates_presence_of :value, :voteable, :user

    belongs_to :voteable, polymorphic: true
    belongs_to :user

    preserve_data
end
