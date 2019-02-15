module Spree
  module Admin
    module Marketing
      module List
        class AbandonedCartsController < ListsController
          before_action :load_contacts, only: :show

          private

          def load_contacts
            @contacts = @marketing_list_abandoned_cart.contacts.order(updated_at: :desc)
          end
        end
      end
    end
  end
end
