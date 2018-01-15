# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :string           not null
#  question_id :integer          not null
#  user_id     :integer          not null
#  accepted    :boolean          default(FALSE)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ApplicationRecord
    commentable
    preserve_data
    revisable
    voteable

    validates_presence_of :text, :question, :user

    belongs_to :question
    belongs_to :user
end
