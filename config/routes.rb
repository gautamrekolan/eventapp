Eventapp::Application.routes.draw do
  
  root :to => "events#index"
  
  resources :events do
    member do
	    post :notify_friend
	    get :tickets
	    # get :search  # TODO figure out where the best place is to implement search
	  end
    resources :comments
    resources :event_likes
    resources :going_tos
  end
  
  resources :places do
    resources :place_comments
  end
  
  resources :users do
    member do
      get :following, :followers, :events_gone_to, :events_created
    end
    collection do 
      get :checkname
    end
  end

  resources :relationships, :only => [:create, :destroy]
  
  resource :session
  
  match '/login' => "sessions#new", :as => "login" 
  match '/logout' => "sessions#destroy", :as => "logout"
  
  match '/signup' => "users#new", :as => "signup"
  
  #searches on events
  match '/search' => 'events#search', :as => "search"
  
  #match '/going' => 

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
