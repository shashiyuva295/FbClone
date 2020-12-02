Rails.application.routes.draw do
  devise_for :users
  #notify_to :users
  get 'welcome/index'
  root to: 'welcome#index'
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
        #get 'suggestion', to: 'posts#suggestion'     
        put "like" => "posts#like"
      end
    end
end
