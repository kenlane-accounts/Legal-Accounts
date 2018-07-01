Rails.application.routes.draw do
  root 'pages#home'

  resources :outlaytypes
  resources :cases do
    get :autocomplete_case_reference, on: :collection
  end

  resources :clients
  resources :casestatuses
  resources :clientstatuses
  resources :suppliers
  resources :vats
  resources :nomtrans
  resources :nominals

  resources :transfers
  namespace :transfers, only: [:show, :destroy] do
    resources :ccbs, only: [:new, :create, :edit, :update]
    resources :ccos, only: [:new, :create, :edit, :update]
    resources :mmbs, only: [:new, :create, :edit, :update]
    resources :mmos, only: [:new, :create, :edit, :update]
    resources :mcbs, only: [:new, :create, :edit, :update]
    resources :cmbs, only: [:new, :create, :edit, :update]
    resources :mnos, only: [:new, :create, :edit, :update]
    resources :nmos, only: [:new, :create, :edit, :update]
  end 

  resources :tranheads 
  namespace :tranheads, only: [:show, :destroy] do
    resources :opsups, only: [:new, :create, :edit, :update]
    resources :opnoms, only: [:new, :create, :edit, :update]
    resources :opmats, only: [:new, :create, :edit, :update]
    resources :ornoms, only: [:new, :create, :edit, :update]
    resources :orsups, only: [:new, :create, :edit, :update]
    resources :ormats, only: [:new, :create, :edit, :update]
  end 

  resources :tranheadclients
  namespace :tranheadclients, only: [:show, :destroy] do
    resources :cpmats, only: [:new, :create, :edit, :update]
    resources :crmats, only: [:new, :create, :edit, :update]
  end 

  resources :tranheadpinvs
  namespace :tranheadpinvs, only: [:show, :destroy] do
    resources :pimats, only: [:new, :create, :edit, :update]
    resources :pcmats, only: [:new, :create, :edit, :update]
    resources :pinoms, only: [:new, :create, :edit, :update]
    resources :pcnoms, only: [:new, :create, :edit, :update]
  end 

  resources :tranheadsinvs
  namespace :tranheadsinvs, only: [:show, :destroy] do
    resources :simats, only: [:new, :create, :edit, :update]
    resources :scmats, only: [:new, :create, :edit, :update]
  end 

  resources :trans

  post 'search_case/search'

  resources :allocations

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
