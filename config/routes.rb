Spree::Core::Engine.routes.draw do
  namespace :admin do
    namespace :marketing do
      resources :lists, only: %i[show index]

      namespace :list do
        resources :abandoned_carts, only: %i[show]
        resources :favourable_products, only: %i[show], controller: '/spree/admin/marketing/lists'
        resources :least_active_users, only: %i[show], controller: '/spree/admin/marketing/lists'
        resources :least_zone_wise_orders, only: %i[show], controller: '/spree/admin/marketing/lists'
        resources :most_active_users, only: %i[show], controller: '/spree/admin/marketing/lists'
        resources :most_discounted_orders, only: %i[show], controller: '/spree/admin/marketing/lists'
        resources :most_searched_keywords, only: %i[show], controller: '/spree/admin/marketing/lists'
        resources :most_used_payment_methods, only: %i[show], controller: '/spree/admin/marketing/lists'
        resources :most_zone_wise_orders, only: %i[show], controller: '/spree/admin/marketing/lists'
        resources :new_users, only: %i[show], controller: '/spree/admin/marketing/lists'
      end


      resources :campaigns, only: %i[show index] do
        member do
          get :display_recipient_emails
        end
      end
      post 'campaigns/sync', to: 'campaigns#sync'
    end
  end
end
