Rails.application.routes.draw do
  resources :activities
  get 'users/show'

  devise_for :users, controllers: { sessions: "users/sessions" }, path: "auth", path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'cmon_let_me_in' }


  resources :users, only: [:show, :edit, :update] do
    resources :closets
    resources :boards
    member do
      get :following, :followers
    end
  end

  namespace :api, :defaults => { :format => 'json' } do
    resources :users, except: [:new, :edit]
    resources :closets, except: [:new, :edit]
    resources :items, except: [:new, :edit]
  end

  resources :items do
    member do
      put "like", to: "items#upvote"
    end
  end

  get '/prices-over-time', to: 'items#prices_over_time'

  resources :closet_items, only: [:create, :new, :destroy]

  resources :relationships, only: [:create, :destroy]

  devise_scope :user do
    authenticated :user do
        root 'boards#index', as: :authenticated_root
    end
    unauthenticated do
      root 'devise/registrations#new', as: :unauthenticated_root
    end
  end

  get '/hidefy', to: 'searches#hidefy'
  resources :searches



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
