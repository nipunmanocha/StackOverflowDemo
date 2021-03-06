# Module to create revisions of a model
module Revisable
  extend ActiveSupport::Concern
  
  included do
    def self.revisable
      has_many :revisions, as: :revisable
      after_save { Revision.create(
          revisable: self, 
          metadata: self.to_json(except: [:id, :created_at, :updated_at])
      ) }
    end
  end
end
