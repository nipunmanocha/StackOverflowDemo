class Question < ApplicationRecord
    validates_presence_of :text, :user_id
    validates_numericality_of :user_id

    belongs_to :user
end
