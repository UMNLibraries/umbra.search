Rails.application.routes.draw do

  resources :featured_images
  resources :featured_boards

  resources :flags
  resources :flag_votes
  post '/flag_votes/create' => 'flag_votes#create', as: 'create_flag_vote'
  delete '/flag_votes/destroy' => 'flag_votes#destroy', as: 'destroy_flag_vote'

  get 'featured_board/preview' => 'featured_boards#preview', as: 'board_preview'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :registrations => "registrations" }
  root :to => 'pages#home'

  blacklight_for :catalog
  get 'thumbnail' => 'thumbnails#download', as: 'cached_thumbnail'

  scope '/about' do
    get '' => 'pages#about', as: 'about'
    get 'history' => 'pages#history', as: 'history'
    get 'copyright' => 'pages#copyright', as: 'copyright'
    get 'team' => 'pages#team', as: 'team'
    get 'contact' => 'pages#contact', as: 'contact'
    get 'participate' => 'pages#participate', as: 'participate'
  end


  get 'contribute' => 'catalog#contribute', as: 'contribute'
  # get 'contact' => 'catalog#contact', as: 'contact'
  # post  'users/:id/update' => 'users#update', as: 'update_user'
  # patch 'users/:id/update' => 'users#update'
  resources :users

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
