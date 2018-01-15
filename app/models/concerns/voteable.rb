# Module to make a model voteable
module Voteable
  extend ActiveSupport::Concern

  included do
    def self.voteable
      has_many :votes, as: :voteable
    end
  end
end
