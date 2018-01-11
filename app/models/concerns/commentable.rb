module Commentable
  extend ActiveSupport::Concern

  included do
    def self.commentable
      has_many :comments, as: :commentable
    end
  end
end
