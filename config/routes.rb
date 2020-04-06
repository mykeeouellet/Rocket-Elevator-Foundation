
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Blazer::Engine, at: 'blazer'

  devise_for :employees

  #controller: the controller which should be used. All routes by default points to Devise controllers, here we set to point to our controller
  devise_for :users, controllers: { sessions: 'users/sessions' } do

    #Session routes for Authenticatable
    # GET /resource/sign_in
    get '/users/sign_in' => 'sessions#new', :as => :new_user_session
    # POST /resource/sign_in
    post '/users/sign_in' => 'sessions#create', :as => :user_session
    # DELETE /resource/sign_out
    get '/users/sign_out' => 'sessions#destroy', :as => :destroy_user_session

    # Password routes for Recoverable, if User model has :recoverable configured
    get '/users/password/new(.:format)' => 'passwords#new', :as => :new_user_password
    get '/users/password/edit(.:format)' => 'passwords#edit', :as => :edit_user_password
    put '/users/password(.:format)' => 'passwords#update', :as => :user_password
    post '/users/password(.:format)' => 'passwords#create'

    # Confirmation routes for Confirmable, if User model has :confirmable configured
    get '/users/confirmation/new(.:format)' => 'confirmations#new', :as => :new_user_confirmation
    get '/users/confirmation(.:format)' => 'confirmations#show', :as => :user_confirmation
    post '/users/confirmation(.:format)' => 'confirmations#create'
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "pages#index_one_page_elevator"
  
  get "pages/index_one_page_elevator"
  get "pages/residential_services"
  get "pages/corporate_services"
  get "pages/SubmissionForm"
  get "pages/login"
  post "quotes" => "quotes#create"
  post "leads" => "leads#create"

  # Dropbox
  get 'dropbox/auth' => 'dropbox#auth'
  get 'dropbox/auth_callback' => 'dropbox#auth_callback'

  # Google Maps
  get 'geolocation/index'
  
  # IBM Watson

  # get VERB at /watson end-point will call Controller#Action = text_to_speech#watson index from text_to_speech_controller.rb 
  # as: articles > as "" is the rails routes.rb prefix_path, (typically specifies page)
  get 'watson' => "text_to_speech#watson"
  post 'watson' => "text_to_speech#watson"
  # get 'admin/root' => "text_to_speech#watson"
end