Sweeper::Application.routes.draw do
  
  get "subscriptions/new"
  get "subscriptions/create"

  get "email_confirmations/confirm"
  get "email_confirmations/confirmation_failed"

  get "static_pages/landing"
  
  match "users/new_person", :to => 'users#create', :via => :post, :as => :post_new_person
  
  get "users/new_person"
  get "users/new"
  
  get "agents/verify"
  
  get "recordings/dial"
  get "recordings/record_landing"
  get "recordings/record_prompt"
  get "recordings/notification"
  get "recordings/record"
  get "recordings/confirm"
  get "recordings/confirm_branch"
  get "recordings/create"
  get "recordings/new"
  get "recordings/success"
  
  get "password_resets/create"
  get "password_resets/edit"
  get "password_resets/update"
  
  get "reminders/email"
  get "reminders/sms"
  get "reminders/voice"

  # authentication routes
  get "login" => "sessions#new", :as => 'login'
  get "logout" => "sessions#destroy", :as => "logout"
  get "signup" => "users#new", :as => "signup"
  get "forgot_password" => "sessions#forgot_password", :as => "forgot_password"
  
  resources :subscriptions
  resources :recordings
  resources :password_resets
  
  resources :users
  
  resources :sessions

  resources :people
  
  resources :notifications

  resources :agents
  
  root :to => "static_pages#landing"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
