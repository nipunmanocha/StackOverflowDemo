class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  include Commentable
  include PreserveData
  include Revisable
  include Voteable
end
