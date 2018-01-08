module Revisable
    extend ActiveSupport::Concern

    included do
        has_many :revisions, as: :revisable

        after_save { Revision.create(revisable: self, metadata: self) }
    end
end