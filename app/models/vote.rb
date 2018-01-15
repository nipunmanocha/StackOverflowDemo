# == Schema Information
#
# Table name: votes
#
#  id            :integer          not null, primary key
#  value         :integer          default(0), not null
#  voteable_type :string           not null
#  voteable_id   :integer          not null
#  user_id       :integer          not null
#  deleted_at    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Vote < ApplicationRecord
    preserve_data

    validates_presence_of :value, :voteable, :user

    belongs_to :voteable, polymorphic: true
    belongs_to :user
end
