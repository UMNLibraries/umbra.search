Rails.application.routes.draw do


  root :to => 'pages#home'
  mount Blacklight::Engine => '/'
  # root to: "catalog#index"
  concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  concern :exportable, Blacklight::Routes::Exportable.new

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  resources :pages
  resources :featured_images
  resources :flags
  resources :flag_votes
  resources :records, only: [:show]

  #require 'sidekiq/web'
  #mount Sidekiq::Web => '/sidekiq'

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
  resources :users
  resources :featured_contents

  resources :suggest, only: :index, defaults: { format: 'json' }

  get 'thumbnail_cache/:record_id' => 'thumbnail_cache#update', as: 'thumbnail_cache'
end
