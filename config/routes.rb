Rails.application.routes.draw do
  get 'followcount/follow'
  get 'followcount/unfollow'
  devise_for :users
  get 'welcome/index'
  root to: 'welcome#index'
  	resources :posts do
  		resources :comments
  		resources :likes
  	end

end
