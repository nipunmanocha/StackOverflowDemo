class Vote < ApplicationRecord
    include SoftDelete

    validates_presence_of :value, :voteable, :user

    belongs_to :voteable, polymorphic: true
    belongs_to :user
end
