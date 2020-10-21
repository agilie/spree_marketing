module Spree
  module Admin
    module Marketing
        class CartsController < Spree::Admin::ResourceController
          before_action :load_orders, only: :show

          def model_class
            Spree::Marketing::Contact
          end

          def load_orders
            @empty_orders =  Spree::Order.includes(:line_items)
                                 .incomplete.where.not(item_count: 0).distinct
                                 .where(email: @marketing_cart.email)
          end

      end
    end
  end
end

