Rails.application.routes.draw do

  resources :pages
  resources :featured_images
  resources :flags
  resources :flag_votes

  get 'widgets/search' => 'widgets#search', as: 'search_widget'

  post '/flag_votes/create' => 'flag_votes#create', as: 'create_flag_vote'
  delete '/flag_votes/destroy' => 'flag_votes#destroy', as: 'destroy_flag_vote'

  get 'featured_board/preview' => 'featured_boards#preview', as: 'board_preview'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :registrations => "registrations" }
  root :to => 'pages#home'

  blacklight_for :catalog
  get 'thumbnail' => 'thumbnails#download', as: 'cached_thumbnail'

  get '/about', to: redirect('/pages/about')
  get '/about/partner', to: redirect('/pages/partner')
  get '/about/history', to: redirect('/pages/history')
  get '/about/copyright', to: redirect('/pages/copyright')
  get '/about/people', to: redirect('/pages/people')
  get '/about/contact', to: redirect('/pages/contact')
  get '/about/participate', to: redirect('/pages/participate')
  get '/about/faq', to: redirect('/pages/faq')
  get '/about/inspirations', to: redirect('/pages/inspirations')

  get 'contribute' => 'catalog#contribute', as: 'contribute'
  # get 'contact' => 'catalog#contact', as: 'contact'
  # post  'users/:id/update' => 'users#update', as: 'update_user'
  # patch 'users/:id/update' => 'users#update'
  resources :users
  resources :featured_contents

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
