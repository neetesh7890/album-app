Rails.application.routes.draw do  
  get 'user_details/new'







  get 'users/login' #new
  delete 'users/logout', to: 'users#logout' #new
  get 'users/new_account_help', to:'users#new_account_help', as: 'new_account_help' #new
  post 'users/create_account_help', to:'users#create_account_help', as: 'account_help' #new
  get '/users/reset_password/:id', to: "users#reset_password", as: 'reset_password'
  post '/users/update_password/:id', to: "users#update_password", as: 'update_password'
  
  resources :users do
    get :verify#old
    
    resources :friends do
      collection do
        # get :verify
         get '/:token/accept', to:'friends#accept', as: 'accept'
      end
    end
    
    resources :albums

    resources :dashboards
  end


  resources :sessions
  
  # resources :users do
  #   get :verify
  # end
  resources :albums do
    delete :destroy_album
    resources :comments do
    
    end
  end 
  get '/albums/my_album/:id', to: "albums#my_album",as: 'my_album'
  get '/albums/friend_album/:id', to: "albums#friend_album",as: 'friend_album'

  resources :friends do
    get :notification
  end
  post 'friends/search', to:'friends#search'

  get 'friends/:token/accept', to:'friends#accept', as: 'friends_accept'
  get 'dashboards/information/:id', to: 'dashboards#information'
  # resources :dashboards

  
  # resources :comments
  post 'albums/:album_id/comments/remark', to:'comments#remark', as: 'comments_remark'

  # get 'actions/login'
  

  # delete 'actions/logout', to: 'actions#logout'

  

  resources :actions
  get 'details_first', to: "users#details_first"
  get 'show_update', to: "users#show_update"
  post 'details_create', to: "users#details_create"
  
  # get '/email_verifier/:id', to: 'users#email_verifier', as: 'email_verifier'
  
  # get '/actions/reset_password/:id', to: "actions#reset_password", as: 'reset_password'

  # post '/actions/update_password/:id', to: "actions#update_password", as: 'update_password'
  # root 'actions#login'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#login'

end
