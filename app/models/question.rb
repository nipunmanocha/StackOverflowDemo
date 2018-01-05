class Question < ApplicationRecord
    validates :text, presence: true
    validates :user_id, presence: true, numericality: true

    belongs_to :user
end
