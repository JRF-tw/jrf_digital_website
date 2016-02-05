Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'static_pages#home'
  match '/about',     to: 'static_pages#about',     via: 'get'
  resources :records, only: [:show, :index] do
    get :articles, on: :collection
    get :propagandas, on: :collection
    get :documents, on: :collection
    get :statements, on: :collection
    get :petitions, on: :collection
    get :affairs, on: :collection
    get :letters, on: :collection
  end
  resources :articles, only: [:show, :index]
  resources :magazines, only: [:show, :index]
  resources :keywords, only: [:show]
  resources :subjects, only: [:show]

  namespace :api do
    resources :articles, only: [:show, :index]
    resources :magazines, only: [:show, :index]
    resources :records, only: [:show, :index]
  end

  get '/api' => redirect('/swagger/dist/index.html?url=/apidocs/api-docs.json')


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
