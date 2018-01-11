module PreserveData
  extend ActiveSupport::Concern

  included do
    def self.preserve_data
      default_scope { where(deleted_at: nil) }

      alias_method :hard_destroy, :destroy

      def destroy
        self.update(deleted_at: Time.now)
      end
    end
  end
end
