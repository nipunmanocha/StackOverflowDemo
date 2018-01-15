# == Schema Information
#
# Table name: tags
#
#  id          :integer          not null, primary key
#  value       :string           not null
#  description :string
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Tag < ApplicationRecord
    preserve_data

    validates_presence_of :value

    has_and_belongs_to_many :questions
end
