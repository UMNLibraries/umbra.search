Rails.application.routes.draw do

  resources :pages
  resources :featured_images
  resources :flags
  resources :flag_votes
  resources :records, only: [:show]

  require 'sidekiq/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end


  get '/contributing-institutions' => "data_providers#index", as: 'data_providers'
  get '/contributing-institutions/:id' => "data_providers#show", as: 'data_provider'

  post '/records/upsert' => 'records#upsert', as: 'records_upsert'
  post '/records/update_tag_list' => 'records#update_tag_list'
  patch '/records/update_tag_list' => 'records#update_tag_list'

  get 'widgets/embed' => 'widgets#embed', as: 'widget'
  get 'widgets' => 'widgets#index', as: 'widgets'

  post '/flag_votes/create' => 'flag_votes#create', as: 'create_flag_vote'
  delete '/flag_votes/destroy' => 'flag_votes#destroy', as: 'destroy_flag_vote'

  get 'featured_board/preview' => 'featured_boards#preview', as: 'board_preview'

  devise_for :users, :controllers => { :registrations => "registrations" }
  root :to => 'pages#home'

  blacklight_for :catalog


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

  resources :suggest, only: :index, defaults: { format: 'json' }

  get 'thumbnail_cache/:record_id' => 'thumbnail_cache#update', as: 'thumbnail_cache'

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
