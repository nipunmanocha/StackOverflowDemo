class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :active, ->{ where(deleted_at: nil) }
end
