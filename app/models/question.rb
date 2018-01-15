# == Schema Information
#
# Table name: questions
#
#  id           :integer          not null, primary key
#  text         :string           not null
#  user_id      :integer          not null
#  duplicate_id :integer
#  wiki         :boolean          default(FALSE)
#  deleted_at   :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Question < ApplicationRecord
    commentable
    preserve_data
    revisable
    voteable

    validates_presence_of :text, :user

    belongs_to :user
    
    has_many :answers
    
    has_and_belongs_to_many :tags
end
