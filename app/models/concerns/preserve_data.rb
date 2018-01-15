# Module to give a soft-delete feature to the models. These include: 
# - providing a default scope
# - overwriting the destroy action
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
