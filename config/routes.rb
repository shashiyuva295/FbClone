Rails.application.routes.draw do
  devise_for :users
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
        put "like" => "posts#like"
      end
    end
end
