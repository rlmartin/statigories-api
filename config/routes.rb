StatigoriesCom::Application.routes.draw do
  root :to => "home#index"

  match 'signature/check', :to => 'home#signature_check', :as => :signature_check
  match 'signature/verify', :to => 'home#signature_verify', :as => :signature_check
  get "time(.:format)", :to => "time#show", :as => :time

  devise_for :users

  devise_for :partners do
    get "sign_in", :to => "devise/sessions#new", :as => :sign_in
    delete "sign_out", :to => "devise/sessions#destroy", :as => :sign_out
    get "sign_up", :to => "devise/registrations#new", :as => :sign_up
  end
  # Unfortunately, have to compile this list manually.
  devise_scope :user do
    get "partners/:partner_id/users/sign_in", :to => "devise/sessions#new", :as => :new_partner_user_session
    post "partners/:partner_id/users/sign_in", :to => "devise/sessions#create", :as => :partner_user_session
    delete "partners/:partner_id/users/sign_out", :to => "devise/sessions#destroy", :as => :destroy_partner_user_session
    post "partners/:partner_id/users/password", :to => "devise/passwords#create", :as => :partner_user_password
    get "partners/:partner_id/users/password/new", :to => "devise/passwords#new", :as => :new_partner_user_password
    get "partners/:partner_id/users/password/edit", :to => "devise/passwords#edit", :as => :edit_partner_user_password
    put "partners/:partner_id/users/password", :to => "devise/passwords#update"
    get "partners/:partner_id/users/cancel", :to => "devise/registrations#cancel", :as => :cancel_partner_user_registration
    post "partners/:partner_id/users", :to => "devise/registrations#create", :as => :partner_user_registration
    get "partners/:partner_id/users/sign_up", :to => "devise/registrations#new", :as => :new_partner_user_registration
    get "partners/:partner_id/users/edit", :to => "devise/registrations#edit", :as => :edit_partner_user_registration
    put "partners/:partner_id/users", :to => "devise/registrations#update"
    delete "partners/:partner_id/users", :to => "devise/registrations#destroy"
  end
  resources :partners, :only => :show do
    resources :api_keys, :only => [:create, :destroy]
    resources :users, :only => :show
  end

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
