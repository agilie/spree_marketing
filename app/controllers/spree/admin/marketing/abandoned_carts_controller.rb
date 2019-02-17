module Spree
  module Admin
    module Marketing
      class AbandonedCartsController < ListsController
        before_action :load_contacts, only: :show

        def model_class
          Spree::Marketing::List::AbandonedCart
        end

        private

        def load_contacts
          @contacts = @marketing_abandoned_cart.contacts.order(updated_at: :desc)
        end

      end
    end
  end
end

