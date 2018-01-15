# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  text             :string           not null
#  commentable_type :string           not null
#  commentable_id   :integer          not null
#  user_id          :integer          not null
#  deleted_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ApplicationRecord
    preserve_data

    validates_presence_of :text, :commentable, :user

    belongs_to :user
    belongs_to :commentable, polymorphic: true
end
