Rails.application.routes.draw do
  get 'charges/new'
  get 'charges/create'
  get 'notifications/index'
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
    #devise_for :users
    #resources :posts
    #root to: 'posts#index'

    # resources :users do
    #  put 'suggestion' => 'users#suggestion'
    # end
end
