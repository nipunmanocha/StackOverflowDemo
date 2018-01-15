# == Schema Information
#
# Table name: revisions
#
#  id             :integer          not null, primary key
#  metadata       :jsonb
#  revisable_type :string           not null
#  revisable_id   :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Revision < ApplicationRecord
    validates_presence_of :revisable

    belongs_to :revisable, polymorphic: true
end
