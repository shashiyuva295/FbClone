Rails.application.routes.draw do
  devise_for :users
  #notify_to :users
  get 'welcome/index'
  root to: 'welcome#index'
  #root to: 'notifications#index'
  
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

end
