Rails.application.routes.draw do
  devise_for :users
  	#notify_to :users
  get 'welcome/index'
  root to: 'welcome#index'
  	resources :posts do
  		resources :comments
  		resources :likes

  	end

end
