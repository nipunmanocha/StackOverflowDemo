class Tag < ApplicationRecord
    validates_presence_of :value

    has_and_belongs_to_many :questions

    preserve_data
end
