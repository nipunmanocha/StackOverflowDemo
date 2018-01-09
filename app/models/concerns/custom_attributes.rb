module CustomAttributes
    extend ActiveSupport::Concern
  
    included do
      def self.preserve_data
        default_scope { where(deleted_at: nil) }
      end

      def self.commentable
        has_many :comments, as: :commentable
      end

      def self.voteable
        has_many :votes, as: :voteable
      end

      def self.revisable
        has_many :revisions, as: :revisable
        after_save { Revision.create(
            revisable: self, 
            metadata: self.to_json(except: [:id, :created_at, :updated_at])
        ) }
      end
    end
  end
  