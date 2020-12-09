Rails.application.routes.draw do
  devise_for :users, 
  controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
  
  #notify_to :users
  get 'welcome/index'
  root to: 'welcome#index'
  #root to: 'notifications#index'
  
  #post "omniauth_callbacks" => "/"
  #post "users/auth/facebook/callback" => "/posts"

  	resources :posts do
  		resources :comments
  		resources :likes
  	end

  	resources :users, only: [:show] do
  		member do
  			get :following, :followers
  			post :follow, :unfollow
  		end
  	end

    resources :posts do
      member do     
        put "like" => "posts#like"
        put "notifications" => "notifications#index"
      end
    end

    resources :charges, only: [:new, :create]
    get 'charges/new'
    get 'charges/create'

    resources :notifications, only: [:index]
    get 'notifications/index'

    resources :suggestions, only: [:index]
    get 'suggestions/index'

    
    resources :orders
    #get 'orders/create_order'
    #get 'orders/capture_order'
    post "create_order" => "orders#create_order"
    post "capture_order" => "orders#capture_order"

end
