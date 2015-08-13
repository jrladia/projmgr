Rails.application.routes.draw do
  root 'projects#index'
  resources :projects, param: :projnumber
  resources :teammembers

  get 'projects/index' => 'projects#index', as: :index_project
  get 'projects/new' => 'projects#new'
  get 'projects/:projnumber/edit' => 'projects#edit'
  get 'projects/:projnumber' => 'projects#show', as: :show_project
  patch 'projects/:projnumber/' => 'projects#update'
  post 'projects/create' => 'projects#create'
  delete 'projects/:projnumber/' => 'projects#destroy'
  
  get 'teammembers/' => 'teammembers#index', as: :index_teammembers
  get 'teammembers/new' => 'teammembers#new'
  get 'teammembers/:id/edit' => 'teammembers#edit'
  get 'teammembers/:id/' => 'teammembers#show', as: :show_teammember
  patch 'teammembers/:id/' => 'teammembers#update'
  post 'teammembers/create' => 'teammembers#create'
  delete 'teammembers/:id/' => 'teammembers#destroy'
  
  
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
