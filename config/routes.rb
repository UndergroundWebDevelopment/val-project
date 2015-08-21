Rails.application.routes.draw do
  root 'home#index'

  resources :actions
  resources :action_logs, only: [:index, :show]
  resources :channels
  resources :conditions
  resources :event_logs, only: [:index, :show, :create]
  resources :operations

  # This endppoint is specifically for channel webhooks to hit. Under the hood
  # it's treated as an HTTP request to a custom controller action that deals
  # with the fact that we don't have control over the _content_ of the webhook,
  # but do have control over the URL, etc. So we tag some extra data (like
  # event type) onto the URL and do a couple other tricks. Using a custom route
  # and controller method for this lets us _also_ maintain a POST
  # /event_logs#create route that responds to a stricter spec.
  post "event_logs/webhook/:type(.:format)", controller: :event_logs, action: :webhook

  get "channels/connect/callback/:service", controller: :channels, action: :connection_callback
  get "channels/connect/:service", controller: :channels, action: :authorize_connection

  # Authentication (sign up, sign in, sign out, etc) routes:
  get "sessions/sign_in"
  post "sessions/sign_up"
  get "sessions/sign_up_form"
  get "sessions/sign_out"
  get "sessions/sign_in_form"
  post "sessions/sign_in"


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
