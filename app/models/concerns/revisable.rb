module Revisable
    extend ActiveSupport::Concern

    included do
        has_many :revisions, as: :revisable
    end
end