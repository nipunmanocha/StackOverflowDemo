class Tag < ApplicationRecord
    include SoftDelete

    validates_presence_of :value

    has_and_belongs_to_many :questions
end
