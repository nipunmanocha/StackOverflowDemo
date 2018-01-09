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
    end
  end